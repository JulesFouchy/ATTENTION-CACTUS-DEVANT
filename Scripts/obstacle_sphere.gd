extends Obstacle

func _on_mask_changed() -> void:
	enabled = not enabled
