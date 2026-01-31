extends ColorRect

@export var effect: MaskState.Effect

func _ready() -> void:
	State.MaskChanged.connect(_on_mask_changed)
	
func _on_mask_changed() -> void:
	visible = MaskState.is_effect_active(effect)
