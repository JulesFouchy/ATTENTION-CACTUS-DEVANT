extends Node3D
class_name MorceauMasque3D

@export var iconemasque_scene: PackedScene

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var gui_instance = iconemasque_scene.instantiate()
			gui_instance.texture = get_child(1).texture
			gui_instance.get_child(0).queue_free()
			gui_instance.position = get_viewport().get_mouse_position()
			gui_instance.position.x -=40
			gui_instance.position.y -=40
			
			get_tree().current_scene.add_child(gui_instance)

			self.queue_free()
