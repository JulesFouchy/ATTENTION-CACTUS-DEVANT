extends Movable
class_name Decors

@export var dist: float = 0.
@export var state: MaskState.Effect
@export var ratio: float = 0.7

func _apply_mask() -> void:
	disapear(state,ratio)

func getdist() -> float:
	return dist
