class_name CardMenuUI
extends CenterContainer

signal tooltip_requested(card: Card)

const BASE_STYLEBOX := preload("res://scenes/card_ui/card_base_stylebox.tres")
const HOVER_STYLEBOX := preload("res://scenes/card_ui/card_hover_stylebox.tres")

@export var card: Card : set = set_card

@onready var visuals: CardVisuals = $Visuals


func _on_visuals_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		tooltip_requested.emit(card)


func _on_visuals_mouse_entered() -> void:
	visuals.panel.set("theme_override_styles/panel", HOVER_STYLEBOX)


func _on_visuals_mouse_exited() -> void:
	visuals.panel.set("theme_override_styles/panel", BASE_STYLEBOX)


func set_card(value: Card) -> void:
	if not is_node_ready():
		await ready

	card = value
	visuals.card = card
