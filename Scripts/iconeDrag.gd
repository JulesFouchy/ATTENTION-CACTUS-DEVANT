extends TextureRect


class_name IconeDrag

@export var _slot: int = -1

func start_drag():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30, 30)

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	texture = null
	if _slot != -1:
		MaskState.set_slot(_slot, 0)
	
	return preview_texture.texture
	
func _can_drop_data(_pos, data):
	return data is Texture2D
	
func _drop_data(_pos,data):
	texture = data
	if _slot != -1:
		MaskState.set_slot(_slot, texture.get_rid().get_id())
		
		
