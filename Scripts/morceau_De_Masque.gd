extends Sprite3D

@export var speed: float = 3.
var textures: Array = []



func _process(delta: float) -> void:
	translate(Vector3( 0,0,+delta * speed))
	if position.x > +10.:
		queue_free()




func _on_area_3d_mouse_entered() -> void:
	print("yeeee")
	pass # Replace with function body.
