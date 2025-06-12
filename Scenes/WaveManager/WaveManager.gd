extends Node2D

const WAVES = preload("res://Resources/Waves.tres")

@onready var paths: Node2D = $Paths
@onready var spawn_timer: Timer = $SpawnTimer


var _wave_count: int = 0 
var _wave_gap: float = 4.0
var _speed_factor: float = 1.0
var _paths_list : Array[Path2D] = []


func _ready() -> void:
	for path in paths.get_children():
		_paths_list.push_back(path) # Replace with function body.


func spawn_wave() -> void: 
	var path: Path2D = _paths_list.pick_random()
	var wave : EnemyWave = WAVES.get_wave_for_wave_count(_wave_count)
