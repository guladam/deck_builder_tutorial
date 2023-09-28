extends CardState


func enter() -> void:
	card.status.text = "CLICK"
	card.color.color = Color.ORANGE
	card.drop_point_detector.monitoring = true


func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, "CardDraggingState")
