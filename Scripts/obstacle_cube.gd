extends Obstacle

@onready var cube_rouge: MeshInstance3D = %"Cube Rouge"
@onready var cube_rose: MeshInstance3D = %"Cube Rose"

func _apply_mask() -> void:
	if MaskState.is_effect_active(MaskState.Effect.CubesArePink):
		cube_rouge.visible = false
		cube_rose.visible = true
	else:
		cube_rouge.visible = true
		cube_rose.visible = false

func _on_area_3d_area_entered(area: Area3D) -> void:
	if cube_rouge.visible and area.is_in_group("Player"):
		get_node("/root/Level/CanvasLayer/Post-process/MegaShader").more_transparency()
	if cube_rose.visible and area.is_in_group("Player"):
		get_node("/root/Level/CanvasLayer/Post-process/MegaShader").less_transparency()
