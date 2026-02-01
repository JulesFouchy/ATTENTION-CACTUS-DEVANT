extends Node3D

@export var obstacle_scenes: Array[PackedScene]
@export var decors_scenes: Array[PackedScene]
@export var mask_textures: Array[Texture2D]
@export var persosajout: Array[PackedScene]

const MORCEAU_DE_MASQUE_3D = preload("uid://bwnft7trmnfmw")
@onready var ambiencebackgroundmusic: AudioStreamPlayer3D = $ambiencebackgroundmusic
@onready var walkingsound: AudioStreamPlayer3D = $walkingsound

@export var x_spawn: float = 50.
@export var y_spawn: float = 10.
@export var TimeInSeconds: float = 1.
@export var max_movables: int = 20000
@export var pick_mask_scene_probability: float = 0.3

var timeurcount: int = 0

var movables_count: int = 0

func _ready() -> void:
	State.level = self
	$Timer.start(TimeInSeconds)
	State.destroyed_movable.connect(_on_movable_destroyed)
	State.LevelInit.emit()
	State.MaskChanged.connect(_on_mask_changed)
	for n in range(0, 1000):
		x_spawn = n / 20.
		var scene_to_spawn
		var decor_to_spawn
		if randf() <= pick_mask_scene_probability:
			scene_to_spawn = MORCEAU_DE_MASQUE_3D.instantiate()
			scene_to_spawn.texture = mask_textures.pick_random()
		else:
			scene_to_spawn = (obstacle_scenes.pick_random()).instantiate()
			decor_to_spawn = (decors_scenes.pick_random()).instantiate()
		if movables_count < max_movables && randf() < scene_to_spawn.spawn_probability:
			spawn(scene_to_spawn)
		if decor_to_spawn != null && movables_count < max_movables && randf() < decor_to_spawn.spawn_probability:
			spawndecor(decor_to_spawn)

	
func _on_mask_changed() -> void:
	var speed = ((50.0 if MaskState.is_effect_active(MaskState.Effect.SpeedUp) else 1.0)
	* (500.0 if MaskState.is_effect_active(MaskState.Effect.SpeedUpExtreme) else 1.0)
	* (0.01 if MaskState.is_effect_active(MaskState.Effect.SlowDown) else 1.0)
	)
	Engine.time_scale = speed
	ambiencebackgroundmusic.pitch_scale = speed
	walkingsound.pitch_scale = speed
		
func spawn(scene_to_spawn) -> void:
	add_child(scene_to_spawn)
	scene_to_spawn.set_global_position(Vector3(x_spawn, 0., randf_range(-y_spawn, y_spawn)))
	movables_count += 1

func spawndecor(decor_to_spawn) -> void:
	add_child(decor_to_spawn)
	var disty = decor_to_spawn.getdist()
	var sens = (randi_range(1, 2) * 2 - 3)
	var randomy = sens * randf_range(disty / 2, disty)
	decor_to_spawn.set_global_position(Vector3(x_spawn, 0., randomy))
	decor_to_spawn.set_global_rotation(Vector3(0, randf_range(0, 360), 0))
	movables_count += 1


func _on_timer_timeout():
	timeurcount += 1
	if (timeurcount % 1000 == 0):
		var chartospawn = (persosajout.pick_random()).instantiate()
		var disty = chartospawn.getdist()
		var randomy = randf_range(disty / 2, disty)
		add_child(chartospawn)
		chartospawn.set_global_position(Vector3(50, 0., randomy))
		
		print(Vector3(50, 0., randomy))
		
	var scene_to_spawn
	var decor_to_spawn
	if randf() <= pick_mask_scene_probability:
		scene_to_spawn = MORCEAU_DE_MASQUE_3D.instantiate()
		scene_to_spawn.texture = mask_textures.pick_random()
	else:
		scene_to_spawn = (obstacle_scenes.pick_random()).instantiate()
		decor_to_spawn = (decors_scenes.pick_random()).instantiate()
	if movables_count < max_movables && randf() < scene_to_spawn.spawn_probability:
		spawn(scene_to_spawn)
	if decor_to_spawn != null && movables_count < max_movables && randf() < decor_to_spawn.spawn_probability:
		spawndecor(decor_to_spawn)
		
	
func _on_movable_destroyed():
	movables_count -= 1
