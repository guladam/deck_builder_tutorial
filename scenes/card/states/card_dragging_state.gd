extends CardState


func enter() -> void:
	card.status.text = "DRAGGING"
	card.color.color = Color.NAVY_BLUE
	card.reparent(get_tree().current_scene)


func exit() -> void:
	pass


func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		card.global_position = card.get_global_mouse_position() - card.size / 2
	
	if event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, "CardBaseState")
		return

	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, "CardReleasedState")
