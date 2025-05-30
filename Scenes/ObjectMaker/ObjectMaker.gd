extends Node2D


const ADD_OBJECT: String = "add_object"
const EXPLOSION = preload("res://Scenes/Explosion/Explosion.tscn")
const POWER_UP = preload("res://Scenes/PowerUp/PowerUp.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _enter_tree() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)
	SignalHub.on_create_powerup.connect(on_create_powerup)
	

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
	
