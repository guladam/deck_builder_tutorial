class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, RELEASED}

signal transition_requested(from: CardState, to: String)

@export var state: State
var card: Card


func enter() -> void:
	pass


func exit() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func on_gui_input(_event: InputEvent) -> void:
	pass
