extends Projectile

class_name HomingMissile

const ROTATION_SPEED: float = 1.2
const SPEED: float = 40.0
const POINT: int = 5

var _player_ref: Player

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir_to_player: Vector2 = global_position.direction_to(_player_ref.global_position)
	var angle_to_player: float = transform.x.angle_to(dir_to_player)
	
	rotate(sign(angle_to_player) * min(abs(angle_to_player), ROTATION_SPEED * delta))
	
	position += transform.x * SPEED * delta

func blow_up() -> void:
	print("Blowing up")
	ScoreManager.increment_score(POINT)
	SignalHub.emit_on_create_explosion(global_position, Explosion.EXPLODE)
	super()
