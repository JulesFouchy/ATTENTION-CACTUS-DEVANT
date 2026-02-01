extends ColorRect

@export var delta_opacity: float = 0.05;
var opacity: float = 0.;

func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	
	self.material.set_shader_parameter("pixalate_enabled", false)
	self.material.set_shader_parameter("vhs_enabled", false)
	self.material.set_shader_parameter("water_enabled", false)
	self.material.set_shader_parameter("negative_enabled", false)
	self.material.set_shader_parameter("edge_enabled", false)
	self.material.set_shader_parameter("radial_aberration_enabled", false)
	self.material.set_shader_parameter("hue_shift_enabled", false)
	self.material.set_shader_parameter("screen_shake_enabled", false)
	self.material.set_shader_parameter("global_opacity", opacity)

func set_shader_boolean(uniform_name, effect) -> void:
	self.material.set_shader_parameter(uniform_name, effect)

func _on_mask_changed() -> void:
	set_shader_boolean(
		"water_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableWater) && (MaskState.is_effect_active(MaskState.Effect.Water) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"vhs_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableVHS) && (MaskState.is_effect_active(MaskState.Effect.VHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"pixelate_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisablePixelate) && (MaskState.is_effect_active(MaskState.Effect.Pixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"negative_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableNegative) && (MaskState.is_effect_active(MaskState.Effect.Negative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"edge_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableEdge) && (MaskState.is_effect_active(MaskState.Effect.Edge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"radial_aberration_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableChromaticAberration) && (MaskState.is_effect_active(MaskState.Effect.ChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"hue_shift_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableHueShift) && (MaskState.is_effect_active(MaskState.Effect.Water) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

	set_shader_boolean(
		"screen_shake_enabled",
	!MaskState.is_effect_active(MaskState.Effect.DisableScreenShake) && (MaskState.is_effect_active(MaskState.Effect.ScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess))
	)

func more_transparency() -> void:
	if opacity >= -0.2:
		opacity += delta_opacity
		set_opacity(opacity)

func less_transparency() -> void:
	if opacity <= 1.2:
		opacity -= delta_opacity
		set_opacity(opacity)

func set_opacity(value: float) -> void:
	if self.material:
		self.material.set_shader_parameter("global_opacity", value)
