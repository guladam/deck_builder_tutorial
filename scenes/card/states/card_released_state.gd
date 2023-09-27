extends CardState


func enter() -> void:
	card.status.text = "RELEASED"
	card.color.color = Color.DARK_VIOLET
	
	if not card.targets.is_empty():
		print("targets:", card.targets)
	else:
		card.reparent(card.parent)


func exit() -> void:
	pass


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, "CardClickedState")
