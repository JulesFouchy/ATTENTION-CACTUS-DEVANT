extends Node3D

@export var speed: float = 3.
var textures: Array = []



func _process(delta: float) -> void:
	translate(Vector3( 0,0,+delta * speed))
	if position.x > +10.:
		queue_free()
