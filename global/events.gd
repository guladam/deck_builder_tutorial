extends Node


signal card_drag_started(card: CardUI)
signal card_drag_ended(card: CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card: Card)

signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested
