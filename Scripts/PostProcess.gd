extends ColorRect

@export var delta_opacity : float = 0.05;
var opacity : float = 0.;

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

func set_shader_boolean(uniform_name, effect) -> void :
	self.material.set_shader_parameter(uniform_name, effect)

func _on_mask_changed() -> void:

	set_shader_boolean(
		"water_enabled",
		MaskState.is_effect_active(MaskState.Effect.Water) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndVHS) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndNegative) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"vhs_enabled",
		MaskState.is_effect_active(MaskState.Effect.VHS) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndVHS) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndNegative) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"pixelate_enabled",
		MaskState.is_effect_active(MaskState.Effect.Pixelate) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndNegative) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"negative_enabled",
		MaskState.is_effect_active(MaskState.Effect.Negative) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndNegative) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndNegative) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndNegative) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"edge_enabled",
		MaskState.is_effect_active(MaskState.Effect.Edge) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndEdge) ||
		MaskState.is_effect_active(MaskState.Effect.EdgeAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.EdgeAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.EdgeAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"radial_aberration_enabled",
		MaskState.is_effect_active(MaskState.Effect.ChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.EdgeAndChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.ChromaticAberrationAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.ChromaticAberrationAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"hue_shift_enabled",
		MaskState.is_effect_active(MaskState.Effect.HueShift) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.EdgeAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.ChromaticAberrationAndHueShift) ||
		MaskState.is_effect_active(MaskState.Effect.HueShiftAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

	set_shader_boolean(
		"screen_shake_enabled",
		MaskState.is_effect_active(MaskState.Effect.ScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.WaterAndScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.VHSAndScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.PixelateAndScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.NegativeAndScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.EdgeAndScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.ChromaticAberrationAndScreenShake) ||
		MaskState.is_effect_active(MaskState.Effect.HueShiftAndScreenShake)||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutWater) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutEdge) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutNegative) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutChromaticAberration) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutVHS) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcessWithoutPixelate) ||
		MaskState.is_effect_active(MaskState.Effect.AllPostProcess)
	)

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
