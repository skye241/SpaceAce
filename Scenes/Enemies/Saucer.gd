extends EnemyBase


class_name Saucer

@onready var shoot_timer: Timer = $ShootTimer
@onready var hitbox: Area2D = $Hitbox

var _is_shooting: bool = false
var _is_dead: bool = false

func _process(delta: float) -> void:
	if !_is_shooting:
		super(delta)

func set_shooting(v: bool) -> void:
	_is_shooting = v

func fire_missile() -> void:
	SignalHub.emit_on_create_homing_missile(global_position)

func _on_shoot_timer_timeout() -> void:
	set_shooting(true) # Replace with function body.

func _on_health_bar_died() -> void:
	_is_dead = true
	shoot_timer.stop()
	set_process(false)
	SpaceUtils.toggle_area2d(hitbox, false)
	ScoreManager.increment_score(points)
	


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		die()
