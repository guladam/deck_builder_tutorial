class_name CardStateMachine
extends Node

@export var initial_state: CardState
var current_state: CardState
var states := {}

func _ready() -> void:
	for child in get_children():
		if child is CardState:
			states[child.name.to_lower()] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card = get_parent()
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)


func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)


func _on_transition_requested(from: CardState, to: String) -> void:
	if from != current_state:
		return
		
	var new_state: CardState = states[to.to_lower()]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
