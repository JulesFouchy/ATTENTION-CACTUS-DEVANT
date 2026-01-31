extends Node3D

@export var masques_scenes:Array[PackedScene]

@export var x_spawn : float = 10.
@export var y_spawn : float = 10.
@export var TimeInSeconds : float = .5
@export var max_obstacles : int = 20

var obstacle_count : int = 0

func spawn_obstacle()-> void:
	var masques_scene = (masques_scenes.pick_random()).instantiate()

	add_child(masques_scene)
	masques_scene.set_global_position(Vector3( x_spawn , randf_range(-y_spawn, y_spawn),0))
	obstacle_count+=1
		
	
	
func _ready() -> void:


	$Timer.start(TimeInSeconds)

func _on_timer_timeout():
	spawn_obstacle()

func _on_obstacle_destroyed():
	obstacle_count -= 1
