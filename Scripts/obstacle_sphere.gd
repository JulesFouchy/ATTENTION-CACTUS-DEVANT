extends Obstacle

var enabled := true:
	set(value): 
		enabled = value
		if enabled:
			visible = true
		else:
			visible = false

func _on_mask_changed() -> void:
	enabled = not enabled

func _on_area_3d_area_entered(area: Area3D) -> void:
	if enabled and area.is_in_group("Player"):
		State.YouLost.emit()
