extends MeshInstance3D

var speed_x: float = 0.2
var speed_y: float = 0.0

func _process(delta):
	var mat := get_surface_override_material(0)

	if mat == null:
		return

	# On décale l’offset UV1
	mat.uv1_offset.x += speed_x * delta
	mat.uv1_offset.y += speed_y * delta
