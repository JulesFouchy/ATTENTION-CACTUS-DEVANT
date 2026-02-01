extends Movable
class_name Obstacle

@export var state: MaskState.Effect
@export var ratio: float = .7

func _apply_mask() -> void:
	disapear(state,ratio)
