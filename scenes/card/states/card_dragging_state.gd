extends CardState


func enter() -> void:
	card.status.text = "DRAGGING"
	card.color.color = Color.NAVY_BLUE
	# Hacky
	card.reparent(get_tree().current_scene.get_node("UI"))
	Events.card_drag_started.emit(card)
	
	if card.data.is_single_targeted():
		var offset := Vector2(card.parent.size.x / 2, -card.size.y)
		offset.x -= card.size.x / 2
		card.global_position = card.parent.global_position + offset
		card.drop_point_detector.monitoring = false


func on_input(event: InputEvent) -> void:
	if not card.data.is_single_targeted() and event is InputEventMouseMotion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	
	if event.is_action_pressed("right_mouse"):
		Events.card_drag_ended.emit(card)
		transition_requested.emit(self, CardState.State.BASE)
		return

	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, CardState.State.RELEASED)
