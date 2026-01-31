extends Node3D
class_name Obstacle

signal destroyed_obstacle

@export var speed: float = 10.
@export var spawn_probability: float = .1

var enabled := true:
	set(value): 
		enabled = value
		if enabled:
			visible = true
		else:
			visible = false
			
func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	
func _on_mask_changed() -> void:
	pass

func _process(delta: float) -> void:
	translate(Vector3(-delta * speed, 0, 0))
	if position.x < -10.:
		destroyed_obstacle.emit()
		queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if enabled and area.is_in_group("Player"):
		State.YouLost.emit()
