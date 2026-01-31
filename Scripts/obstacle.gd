extends Node3D
class_name Obstacle

@export var speed: float = 3.

func _process(delta: float) -> void:
	translate(Vector3(-delta * speed, 0, 0))
	if position.x < -10.: 
		queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	State.score += 1
	print(State.score)
