extends Node

enum Effect {
	SpheresDisappear,
	CubesArePink,
	Dissolve,
	Water,
	VHS,
	Pixelate,
	Negative,
	Edge,
	ChromaticAberration,
	HueShift,
	ScreenShake,
	AllPostProcess,
	AllPostProcessWithoutWater,
	AllPostProcessWithoutVHS,
	AllPostProcessWithoutChromaticAberration,
	AllPostProcessWithoutEdge,
	AllPostProcessWithoutScreenShake,
	AllPostProcessWithoutPixelate,
	AllPostProcessWithoutNegative,
	WaterAndVHS,
	WaterAndPixelate,
	WaterAndNegative,
	WaterAndEdge,
	WaterAndChromaticAberration,
	WaterAndHueShift,
	WaterAndScreenShake,
	VHSAndPixelate,
	VHSAndNegative,
	VHSAndEdge,
	VHSAndChromaticAberration,
	VHSAndHueShift,
	VHSAndScreenShake,
	PixelateAndNegative,
	PixelateAndEdge,
	PixelateAndChromaticAberration,
	PixelateAndHueShift,
	PixelateAndScreenShake,
	NegativeAndEdge,
	NegativeAndChromaticAberration,
	NegativeAndHueShift,
	NegativeAndScreenShake,
	EdgeAndChromaticAberration,
	EdgeAndHueShift,
	EdgeAndScreenShake,
	ChromaticAberrationAndHueShift,
	ChromaticAberrationAndScreenShake,
	HueShiftAndScreenShake,
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
	_slots.resize(5)
	_effects_to_assign = Effect.values()
	_effects_to_assign.shuffle()
