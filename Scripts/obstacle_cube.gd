extends Obstacle

@onready var cube_rouge: MeshInstance3D = %"Cube Rouge"
@onready var cube_rose: MeshInstance3D = %"Cube Rose"


func _on_mask_changed() -> void:
	cube_rouge.visible = not cube_rouge.visible
	cube_rose.visible = not cube_rose.visible
