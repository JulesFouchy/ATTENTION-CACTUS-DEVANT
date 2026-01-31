extends Area3D
@onready var mesh_instance_3d: MeshInstance3D = $"../MeshInstance3D"

func _on_body_entered(body: Node3D) -> void:
	print(body)
