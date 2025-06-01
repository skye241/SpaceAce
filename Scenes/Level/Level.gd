extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("explode"):
		#SignalHub.emit_on_create_powerup(Vector2(405, 200), PowerUp.PowerUpType.Health)
		SignalHub.emit_on_create_bullet(Vector2(300, 300), Vector2.UP, Bullet.BulletType.PlayerBullet, 100)
		SignalHub.emit_on_create_bullet(Vector2(400, 200), Vector2(0.5, 0.5), Bullet.BulletType.BombBullet, 70)
		SignalHub.emit_on_create_bullet(Vector2(500, 200), Vector2.DOWN, Bullet.BulletType.EnemyBullet, 70)
		#SignalHub.emit_on_create_random_powerup(Vector2(400, 200))
		#SignalHub.emit_on_create_explosion(Vector2(300, 300), Explosion.BOOM)
