extends Node3D
@onready var ui_game_over: Control = %UiGameOver

@export var obstacle_scenes:Array[PackedScene]
@export var mask_scenes:Array[PackedScene]

@export var x_spawn : float = 50.
@export var y_spawn : float = 10.
@export var TimeInSeconds : float = 1.
@export var max_movables : int = 20

var movables_count : int = 0

func _ready() -> void:
	$Timer.start(TimeInSeconds)
	State.YouLost.connect(_on_you_lost)
	State.TryAgain.connect(_on_try_again)
	State.destroyed_obstacle.connect(_on_movable_destroyed)
	
func spawn(scene_to_spawn) -> void:
	add_child(scene_to_spawn)
	scene_to_spawn.set_global_position(Vector3(x_spawn,0. , randf_range(-y_spawn, y_spawn)))
	movables_count+=1
	
func _on_timer_timeout():
	var scene_to_spawn = (obstacle_scenes.pick_random()).instantiate()
	var obstacle_to_spawn = (obstacle_scenes.pick_random()).instantiate()
	var mask_scene = (mask_scenes.pick_random()).instantiate()
	if movables_count < max_movables && randf() < obstacle_to_spawn.spawn_probability :
		spawn(obstacle_to_spawn)
		spawn(mask_scene)

func _input(event):
	if Input.is_action_just_pressed("interact"):
		State.MaskChanged.emit()
	
func _on_movable_destroyed():
	movables_count -= 1
	
func _on_you_lost() -> void:
	ui_game_over.visible = true
	
func _on_try_again() -> void:
	ui_game_over.visible = false
