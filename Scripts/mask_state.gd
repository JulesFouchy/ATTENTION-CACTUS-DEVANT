extends Node

enum Effect {
	SpheresDisappear,
	CubesArePink,
	Water,
	VHS,
	Pixelate,
	Negative,
	Edge,
	ChromaticAberration,
	HueShift,
}

var _slots: Array[int]
var _effects_to_assign: Array
var _map: Dictionary

func set_slot(i: int, mask_piece: int) -> void:
	_slots[i] = mask_piece
	State.MaskChanged.emit()

func is_effect_active(effect: Effect) -> bool:
	for i in len(_slots):
		var slot = _slots[i]
		if slot != 0 and _get_effect(i, slot) == effect:
			return true
	return false

func _get_effect(i: int, mask_piece: int) -> Effect:
	if !_map.has([i, mask_piece]):
		var effect = _effects_to_assign.back()
		_effects_to_assign.pop_back()
		if _effects_to_assign.is_empty():
			_effects_to_assign = Effect.values()
			_effects_to_assign.shuffle()
		_map[[i, mask_piece]] = effect
	return _map[[i, mask_piece]]

func _ready() -> void:
	_slots.resize(4)
	_effects_to_assign = Effect.values()
	_effects_to_assign.shuffle()
