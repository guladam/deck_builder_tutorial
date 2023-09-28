class_name CardState
extends Node

signal transition_requested(from: CardState, to: String)

var card: Card


func enter() -> void:
	pass


func exit() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func on_gui_input(_event: InputEvent) -> void:
	pass
