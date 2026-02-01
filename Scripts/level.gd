extends Node3D
@onready var ui_game_over: Control = %UiGameOver

@export var obstacle_scenes: Array[PackedScene]
@export var decors_scenes: Array[PackedScene]
@export var mask_textures: Array[Texture2D]
const MORCEAU_DE_MASQUE_3D = preload("uid://bwnft7trmnfmw")

@export var x_spawn: float = 50.
@export var y_spawn: float = 10.
@export var TimeInSeconds: float = 1.
@export var max_movables: int = 20000
@export var pick_mask_scene_probability: float = 0.3

var movables_count: int = 0

func _ready() -> void:
	$Timer.start(TimeInSeconds)
	State.YouLost.connect(_on_you_lost)
	State.TryAgain.connect(_on_try_again)
	State.destroyed_movable.connect(_on_movable_destroyed)
	
func spawn(scene_to_spawn) -> void:
	add_child(scene_to_spawn)
	scene_to_spawn.set_global_position(Vector3(x_spawn, 0., randf_range(-y_spawn, y_spawn)))
	movables_count += 1

func spawndecor(decor_to_spawn) -> void:

	add_child(decor_to_spawn)
	var disty = decor_to_spawn.getdist()
	var sens = (randi_range(1,2)*2-3)
	print(sens)
	var randomy = sens*randf_range(disty/2,disty)
	print(randomy)
	decor_to_spawn.set_global_position(Vector3(x_spawn, 0.,randomy))
	decor_to_spawn.set_global_rotation(Vector3(0,randf_range(0,360),0))
	movables_count += 1


func _on_timer_timeout():
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
	if decor_to_spawn !=null && movables_count < max_movables && randf() < decor_to_spawn.spawn_probability :
		spawndecor(decor_to_spawn)
		
	
func _on_movable_destroyed():
	movables_count -= 1
	
func _on_you_lost() -> void:
	ui_game_over.visible = true
	
func _on_try_again() -> void:
	ui_game_over.visible = false
