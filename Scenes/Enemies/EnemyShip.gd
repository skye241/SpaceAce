extends EnemyBase


@export var shoots_at_player: bool = false
@export var aims_at_player: bool = false

@export var bullet_type: Bullet.BulletType =  Bullet.BulletType.EnemyBullet
@export var bullet_speed: float = 120.0
@export var bullet_direction: Vector2 = Vector2.DOWN
@export var bullet_wait_time: float = 3.0
@export var bullet_wait_time_var: float = 0.5
@export var power_up_chance: float = 0.9

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var laser_timer: Timer = $LaserTimer
@onready var sound: AudioStreamPlayer2D = $Sound

var _player_ref: Player

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		queue_free()
	
	start_shoot_timer()


func start_shoot_timer() -> void: 
	SpaceUtils.set_and_start_timer(laser_timer, bullet_wait_time, bullet_wait_time_var)
	

func shoot() -> void:
	if aims_at_player: 
		bullet_direction = global_position.direction_to(_player_ref.global_position).normalized()
		
	SignalHub.emit_on_create_bullet(Vector2(global_position.x, global_position.y + 20), bullet_direction, bullet_type, bullet_speed)
	sound.play()
	start_shoot_timer()

func die() -> void:
	if randf() < power_up_chance:
		SignalHub.emit_on_create_random_powerup(global_position)
	super()


func _on_laser_timer_timeout() -> void:
	if shoots_at_player:
		shoot()
