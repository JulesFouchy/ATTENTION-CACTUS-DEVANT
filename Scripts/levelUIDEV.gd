extends Node3D

@export var masques_scenes:Array[PackedScene]

@export var x_spawn : float = 10.
@export var y_spawn : float = 10.
@export var TimeInSeconds : float = .5
@export var max_obstacles : int = 20

var obstacle_count : int = 0

func spawn_obstacle()-> void:
	print("rrrr")
	var masques_scene = (masques_scenes.pick_random()).instantiate()

	add_child(masques_scene)
	print("nouveau")
	masques_scene.set_global_position(Vector3( x_spawn , randf_range(-y_spawn, y_spawn),0))
	obstacle_count+=1
		
	
	
func _ready() -> void:
	print("Timer exists:", $Timer)
	print("Timer wait time:", $Timer.wait_time)
	print("Timer one_shot:", $Timer.one_shot)


	$Timer.start(TimeInSeconds)

func _on_timer_timeout():
	print("timeout")
	spawn_obstacle()

func _on_obstacle_destroyed():
	obstacle_count -= 1
