extends ColorRect

const LEVEL_OPACITY_2 = preload("res://Shaders/LevelOpacity.gdshader")

@export var delta_opacity : float = 0.05;
var opacity : float = 0.;

func _ready() -> void:
	var material = ShaderMaterial.new()
	material.shader = LEVEL_OPACITY_2
	self.material = material
	self.material.set_shader_parameter("opacity", 0.)

func _process(delta: float) -> void:
	pass

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
		self.material.set_shader_parameter("opacity", value)
