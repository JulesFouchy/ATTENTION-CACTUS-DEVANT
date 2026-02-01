extends Node3D
class_name MorceauMasque3D

@export var iconemasque_scene: PackedScene

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var preview_texture = TextureRect.new()
			preview_texture.texture = get_child(1).texture
			preview_texture.expand_mode = 1
			preview_texture.size = Vector2(100,100)
			preview_texture.position = Vector2(-50, -50)
			
			var preview = Control.new()
			preview.add_child(preview_texture)
			
			var control: Control = State.ui_game
			control.force_drag(preview_texture.texture, preview)
			self.queue_free()
