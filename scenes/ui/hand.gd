class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var card_ui := preload("res://scenes/card/card_ui.tscn")

var cards_played_this_turn := 0


func _ready() -> void:
	Events.card_played.connect(_on_card_played)


func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats


func discard_card(card: CardUI) -> void:
	char_stats.discard.add_card(card.card)
	card.queue_free()


func disable_hand() -> void:
	for card in get_children():
		card.disabled = true


func _on_card_played(card: Card) -> void:
	cards_played_this_turn += 1
	char_stats.discard.add_card(card)


func _on_card_ui_reparent_requested(child: CardUI, index: int) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(index - cards_played_this_turn, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
	

func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
