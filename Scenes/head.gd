extends Control

func _ready() -> void:
	var slot: IconeDrag = get_children().pick_random()
	slot.start_with_a_piece = true
