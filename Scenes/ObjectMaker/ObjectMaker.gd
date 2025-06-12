extends Node2D


const ADD_OBJECT: String = "add_object"
const EXPLOSION = preload("res://Scenes/Explosion/Explosion.tscn")
const POWER_UP = preload("res://Scenes/PowerUp/PowerUp.tscn")
const HOMING_MISSILE = preload("res://Scenes/HomingMissile/HomingMissile.tscn")

const BULLET_SCENES: Dictionary[Bullet.BulletType, PackedScene] = {
	Bullet.BulletType.PlayerBullet : preload("res://Scenes/Bullet/BulletPlayer.tscn"),
	Bullet.BulletType.EnemyBullet : preload("res://Scenes/Bullet/EnemyBullet.tscn"),
	Bullet.BulletType.BombBullet : preload("res://Scenes/Bullet/BulletBomb.tscn"),	
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _enter_tree() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)
	SignalHub.on_create_powerup.connect(on_create_powerup)
	SignalHub.on_create_bullet.connect(on_create_bullet)
	SignalHub.on_create_homing_missile.connect(on_create_homing_missile)

func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func on_create_explosion(pos: Vector2, anim: String) -> void:
	var exp = EXPLOSION.instantiate()
	exp.setup(anim)
	call_deferred("add_object", exp, pos)
	
func on_create_powerup(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	var pow = POWER_UP.instantiate()
	pow.setup(type)
	call_deferred("add_object", pow, pos)
	
func on_create_bullet(pos: Vector2,  dir: Vector2,type: Bullet.BulletType, speed: float) -> void:
	var bullet: Bullet = BULLET_SCENES[type].instantiate()
	bullet.setup(dir, speed, type)
	call_deferred("add_object", bullet, pos)

func on_create_homing_missile(pos: Vector2) -> void:
	var missile = HOMING_MISSILE.instantiate()
	call_deferred("add_object", missile, pos)
	
