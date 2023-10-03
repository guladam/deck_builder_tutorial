extends CardState


func enter() -> void:
	card.status.text = "RELEASED"
	card.color.color = Color.DARK_VIOLET
	Events.card_drag_ended.emit(card)


func _physics_process(_delta: float) -> void:
	if not card.targets.is_empty():
		print("targets:", card.targets)
	else:
		transition_requested.emit(self, CardState.State.BASE)
	
	set_physics_process(false)
