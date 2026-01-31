extends Sprite3D

@export var speed: float = 3.
var textures: Array = []

func _ready():
	_load_textures_from_folder("res://IconesPNG/")
	if textures.size() > 0:
		var random_tex = textures.pick_random()
		material_override = StandardMaterial3D.new()
		material_override.albedo_texture = random_tex

func _load_textures_from_folder(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				var tex = load(path + file_name)
				textures.append(tex)
			file_name = dir.get_next()
		dir.list_dir_end()

func _process(delta: float) -> void:
	translate(Vector3( 0,0,+delta * speed))
	if position.x < -10.:
		emit_signal("destroyed_obstacle") 
		queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	State.score += 1
	print(State.score)
	
