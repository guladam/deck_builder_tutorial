extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.2
var minimum_drag_time_elapsed := false


func enter() -> void:
	card_ui.panel.set("theme_override_styles/panel", card_ui.DRAG_STYLEBOX)
	# Hacky
	card_ui.reparent(get_tree().current_scene.get_node("UI"))
	Events.card_drag_started.emit(card_ui)
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(_on_threshold_timeout)


func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return

	elif mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if event.is_action_pressed("right_mouse"):
		Events.card_drag_ended.emit(card_ui)
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and (event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")):
		transition_requested.emit(self, CardState.State.RELEASED)
		get_viewport().set_input_as_handled()


func _on_threshold_timeout() -> void:
	minimum_drag_time_elapsed = true
