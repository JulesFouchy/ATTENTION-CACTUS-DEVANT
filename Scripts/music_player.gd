extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play( randf_range(0.,5400.))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(volume_db<0.):
		volume_db += delta*2.5;
	pass
