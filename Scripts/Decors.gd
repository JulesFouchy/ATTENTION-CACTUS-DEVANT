extends Movable
class_name Decors

@export var dist: float = 0.

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		get_node("/root/Scripts/scene_fader").start_fade()  # Appelle le fondu

func getdist() -> float:
	return dist
