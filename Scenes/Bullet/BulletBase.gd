extends Projectile

class_name Bullet

enum BulletType {PlayerBullet, EnemyBullet, BombBullet}


var _direction: Vector2 = Vector2.ZERO
var _speed: float = 80.0
var _type : BulletType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_type() -> BulletType:
	return _type

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += _speed * _direction * delta

func setup(dir: Vector2, speed: float, type: BulletType) -> void:
	_direction = dir.normalized()
	_speed = speed
	_type = type
	

func blow_up() -> void:
	SignalHub.emit_on_create_explosion(global_position, Explosion.EXPLODE)
	super()
