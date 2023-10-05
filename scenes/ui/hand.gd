extends HBoxContainer


@export var char_stats: CharacterStats

var cards_played_this_turn := 0


func _ready() -> void:
	# This is temporary, since we dont have a turn manager yet
	if char_stats:
		char_stats.stats_changed.connect(_set_cards_playable)
		char_stats.reset_mana()
		
	# Should this be the hand's responsibility?
	Events.card_played.connect(func(c): char_stats.mana -= c.cost)
	# Is this an elegant way to do it?
	Events.card_played.connect(func(_c): cards_played_this_turn += 1)
	
	Events.card_drag_started.connect(_on_card_drag_started)
	Events.card_drag_ended.connect(_on_card_drag_ended)
	
	for child in get_children():
		child.reparent_requested.connect(_on_card_ui_reparent_requested)
	

func set_char_stats(value: CharacterStats) -> void:
	if char_stats:
		char_stats.stats_changed.disconnect(_set_cards_playable)
	
	char_stats = value
	char_stats.stats_changed.connect(_set_cards_playable)
	_set_cards_playable()


func _set_cards_playable() -> void:
	var card_ui_child: CardUI
	
	for child in get_children():
		card_ui_child = child as CardUI
		card_ui_child.playable = char_stats.can_play_card(card_ui_child.card)


func _on_card_ui_reparent_requested(child: CardUI, index: int) -> void:
	var new_index := clampi(index - cards_played_this_turn, 0, get_child_count())
	move_child.call_deferred(child, new_index)


func _on_card_drag_started(card: CardUI) -> void:
	for child in get_children():
		if child != card:
			child.disabled = true


func _on_card_drag_ended(_card: CardUI) -> void:
	for child in get_children():
		child.disabled = false

	_set_cards_playable()
