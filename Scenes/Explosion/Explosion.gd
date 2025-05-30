extends Node2D

class_name Explosion

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const BOOM: String = "boom"
const EXPLODE: String = "explode"

var _anim_name = EXPLODE


func _ready() -> void:
	animated_sprite_2d.animation = _anim_name
	animated_sprite_2d.play(_anim_name) # Replace with function body.


func setup(anim: String) -> void: 
	_anim_name = anim

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free() # Replace with function body.
