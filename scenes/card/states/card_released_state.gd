extends CardState


func enter() -> void:
	Events.card_drag_ended.emit(card_ui)


func _physics_process(_delta: float) -> void:
	if not card_ui.targets.is_empty():
		card_ui.play()
	else:
		transition_requested.emit(self, CardState.State.BASE)
	
	set_physics_process(false)
