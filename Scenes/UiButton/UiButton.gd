extends TextureButton
@onready var label: Label = $Label

@export var text: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = text # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
