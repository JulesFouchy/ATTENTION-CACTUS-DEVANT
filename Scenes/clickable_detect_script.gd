extends Node3D

var mouse = Vector2()

@export var DIST: float = 1000




func _input(event: InputEvent) -> void:
		if event is InputEventMouseMotion:
			mouse = event.position
		if event is InputEventMouseButton:
			if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
				get_mouse_world_pos(mouse)


func get_mouse_world_pos(mouse:Vector2):
	var space = get_world_3d().direct_space_state
	var start =  get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse,DIST)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	# Debug : dessine le rayon
	#DebugDraw3D.draw_line(start, end, Color.RED, 0.1)

	var result = space.intersect_ray(params)
	print(result)
	
