extends Node


signal on_player_hit(v: int)
signal on_score_updated(v: int)
signal on_create_explosion(pos: Vector2, anim: String)
signal on_create_powerup(pos: Vector2, type: PowerUp.PowerUpType)
signal on_create_random_powerup(pos: Vector2)
signal on_create_bullet(pos: Vector2, dir: Vector2, type: Bullet.BulletType, speed: float)

func emit_on_player_hit(v: int) -> void:
	on_player_hit.emit(v)


func emit_on_score_updated(v: int):
	on_score_updated.emit(v)

func emit_on_create_explosion(pos: Vector2, anim: String) -> void:
	on_create_explosion.emit(pos, anim)
	
func emit_on_create_powerup(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	on_create_powerup.emit(pos, type)

func emit_on_create_random_powerup(pos: Vector2) -> void:
	var rand_type: PowerUp.PowerUpType = PowerUp.PowerUpType.values().pick_random()
	on_create_powerup.emit(pos, rand_type)

func emit_on_create_bullet(pos: Vector2, dir: Vector2, type: Bullet.BulletType, speed: float) -> void:
	on_create_bullet.emit(pos, dir, type, speed)
