extends Obstacle

@onready var cube_rouge: MeshInstance3D = %"Cube Rouge"
@onready var cube_rose: MeshInstance3D = %"Cube Rose"

func _on_mask_changed() -> void:
	if MaskState.is_effect_active(MaskState.Effect.CubesArePink):
		cube_rouge.visible = false
		cube_rose.visible = true
	else:
		cube_rouge.visible = true
		cube_rose.visible = false

func _on_area_3d_area_entered(area: Area3D) -> void:
	if cube_rouge.visible and area.is_in_group("Player"):
		State.YouLost.emit()
