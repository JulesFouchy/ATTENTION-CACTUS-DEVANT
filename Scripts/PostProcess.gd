extends ColorRect

@export var delta_opacity : float = 0.05;
var opacity : float = 0.;

func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	
	self.material.set_shader_parameter("vhs_enabled", false)
	self.material.set_shader_parameter("water_enabled", false)
	self.material.set_shader_parameter("enable_flip_horizontal", false)
	self.material.set_shader_parameter("enable_flip_vertical", false)
	self.material.set_shader_parameter("global_opacity", opacity)

func set_shader_boolean(boolean, effect) -> void :
	if MaskState.is_effect_active(effect):
		self.material.set_shader_parameter(boolean, true)
	else:
		self.material.set_shader_parameter(boolean, false)

func _on_mask_changed() -> void:
	set_shader_boolean("vhs_enabled", MaskState.Effect.VHS)
	set_shader_boolean("water_enabled", MaskState.Effect.Water)
	set_shader_boolean("enable_flip_horizontal", MaskState.Effect.HorizontalFlip)
	set_shader_boolean("enable_flip_vertical", MaskState.Effect.VerticalFlip)

func more_transparency() ->void :
	if opacity >= -0.2:
		opacity += delta_opacity
		set_opacity(opacity)

func less_transparency() ->void :
	if opacity <= 1.2:
		opacity -= delta_opacity
		set_opacity(opacity)

func set_opacity(value: float) -> void:
	if self.material:
		self.material.set_shader_parameter("global_opacity", value)
