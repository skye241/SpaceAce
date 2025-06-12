extends PathFollow2D

class_name EnemyBase

@export var points: int = 10
@export var crash_damage: int = 10
@onready var booms: Node2D = $Booms
@onready var health_bar: HealthBar = $HealthBar

var _speed: float = 40


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * _speed
	if progress_ratio >= 0.99:
		queue_free()

func make_booms() -> void:
	for b in booms.get_children():
		SignalHub.emit_on_create_explosion(
			b.global_position,
			Explosion.BOOM
		)	


func die() -> void:
	make_booms()
	call_deferred("queue_free")

func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area)
	if area is Bullet:
		if area.get_type() == Bullet.BulletType.PlayerBullet:
			health_bar.take_damage(area.get_damage())
			


func _on_health_bar_died() -> void:
	ScoreManager.increment_score(points)
	die() # Replace with function body.
