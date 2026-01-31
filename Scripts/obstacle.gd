extends Movable
class_name Obstacle

func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	
func _on_mask_changed() -> void:
	pass

func _on_area_3d_area_entered(area: Area3D) -> void:
	pass

func destroy():
	State.destroyed_obstacle.emit()
	super.destroy()
	
