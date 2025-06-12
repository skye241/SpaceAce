extends Area2D


class_name Player


const GROUP_NAME: String = "Player"
const LIMIT: float = 20.0
@export var health_boost: int = 25
@export var speed: float = 250.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _lower_right: Vector2
var _upper_left: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var vp: Rect2 = get_viewport_rect()
	_lower_right = Vector2(vp.end.x - LIMIT, vp.end.y - LIMIT)
	_upper_left = Vector2(LIMIT, LIMIT)


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = get_input()
	global_position += input * delta * speed
	global_position = global_position.clamp(_upper_left, _lower_right)
	shoot()

func get_input() -> Vector2:
	var v = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	
	if v.x != 0:
		animation_player.play("turn")
		sprite_2d.flip_h = v.x > 0
	else:
		animation_player.play("fly")
	
	return v.normalized()

func shoot() -> void:
	if Input.is_action_just_pressed("shoot"):
		SignalHub.emit_on_create_bullet(global_position, Vector2.UP, Bullet.BulletType.PlayerBullet, speed)

func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp: 
		if area.power_up_type == PowerUp.PowerUpType.Shield:
			shield.enable_shield()
		elif area.power_up_type == PowerUp.PowerUpType.Health:
			SignalHub.emit_on_player_health_bonus(health_boost)
	elif area is Projectile && !shield.visible:
		SignalHub.emit_on_player_hit(area.get_damage())
	elif area.get_parent() is EnemyBase: 
		SignalHub.emit_on_player_hit(area.get_parent().crash_damage)
		
