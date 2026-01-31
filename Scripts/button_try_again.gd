extends Button

func _on_pressed() -> void:
	State.TryAgain.emit()
