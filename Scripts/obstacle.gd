extends Movable
class_name Obstacle

func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	_apply_mask()
	
func _on_mask_changed() -> void:
	_apply_mask()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		get_node("/root/Scripts/scene_fader").start_fade()  # Appelle le fondu

func _apply_mask() -> void:
	pass
