extends Node3D
var obstacle_scene: PackedScene = preload("res://Scenes/obstacle.tscn")

func _ready() -> void:
	add_child(obstacle_scene.instantiate())
