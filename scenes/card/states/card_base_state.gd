extends CardState


func enter() -> void:
	if not card.is_node_ready():
		await card.ready

	card.status.text = "DRAWN"
	card.color.color = Color.WEB_GREEN
	card.reparent(card.parent)


func exit() -> void:
	pass


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, "CardClickedState")
