extends Node3D
class_name Movable

@export var spawn_probability: float = .1
@export var speed: float = 1.

func _process(delta: float) -> void:
	global_translate(Vector3(-delta * speed, 0, 0))
	if position.x < -10.:
		destroy()
		
func destroy():
	queue_free()
	
