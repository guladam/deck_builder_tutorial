extends CardState


func enter() -> void:
	if not card.is_node_ready():
		await card.ready

	card.reparent(card.parent)
	card.parent.move_child.call_deferred(card, card.original_index)
	card.color.color = Color.WEB_GREEN
	card.status.text = "DRAWN"
	card.pivot_offset = Vector2.ZERO


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, CardState.State.CLICKED)
		card.pivot_offset = card.get_global_mouse_position() - card.global_position
