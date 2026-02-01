extends TextureRect
class_name IconeDrag

@export var is_visible := true
@export var start_with_a_piece := false

@onready var panel: Panel = $Panel

@export var _slot: int = -1

func _ready() -> void:
	panel.visible = is_visible
	if start_with_a_piece:
		State.LevelInit.connect(_on_level_init)

func _on_level_init() -> void:
	texture = State.level.mask_textures.pick_random()
	
func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(100,100)
	preview_texture.position = Vector2(-50, -50)
	
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
		
		
