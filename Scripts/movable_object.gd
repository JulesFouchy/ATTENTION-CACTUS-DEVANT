extends Node3D
class_name Movable

@export var spawn_probability: float = .1
@export var speed: float = .2
@export var material : Material = preload("uid://fleyil8gndpe")

func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	_apply_mask()
	_apply_mask2()
	
func _on_mask_changed() -> void:
	_apply_mask()
	_apply_mask2()
	
func _apply_mask() -> void:
	pass

func _process(delta: float) -> void:
	global_translate(Vector3(-delta * speed, 0, 0))
	if position.x < -10.:
		destroy()
		
func destroy():
	State.destroyed_movable.emit()
	queue_free()

func apply_dissolve(mesh: MeshInstance3D) -> void:
	mesh.material_override = material
func remove_dissolve(mesh: MeshInstance3D)->void:
	mesh.material_override = null
	
func _apply_mask2() -> void:
	if MaskState.is_effect_active(MaskState.Effect.Dissolve) and (randf() < 0.5):
		_for_each_mesh(apply_dissolve)
	else:
		_for_each_mesh(remove_dissolve)

func _for_each_mesh(callback: Callable):
	for child in get_children():
		if child is MeshInstance3D:
			callback.call(child)
		for child2 in child.get_children():
			if child2 is MeshInstance3D:
				callback.call(child2)
			for child3 in child2.get_children():
				if child3 is MeshInstance3D:
					callback.call(child3)
								

func disapear (effect, ratio) -> void:
	if MaskState.is_effect_active(effect) and (randf() < ratio):
		visible = false
	else:
		visible = true
