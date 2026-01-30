extends Label

func _ready() -> void:
	State.ScoreChanged.connect(update_score)
	update_score()

func update_score() -> void:
	text = str(State.score)
