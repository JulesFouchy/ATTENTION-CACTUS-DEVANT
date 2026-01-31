extends Node3D
class_name Obstacle

signal destroyed_obstacle

@export var speed: float = 10.
@export var spawn_probability: float = .1

func _process(delta: float) -> void:
	translate(Vector3(-delta * speed, 0, 0))
	if position.x < -10.:
		emit_signal("destroyed_obstacle")
		queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	State.YouLost.emit()
