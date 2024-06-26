extends Relic

var relic_ui: RelicUI


func initialize_relic(owner: RelicUI) -> void:
	relic_ui = owner
	Events.player_hand_drawn.connect(_on_player_hand_drawn)


func deactivate_relic(_owner: RelicUI) -> void:
	Events.player_hand_drawn.disconnect(_on_player_hand_drawn)


func _on_player_hand_drawn() -> void:
	relic_ui.flash()
	var player_handler := relic_ui.get_tree().get_first_node_in_group("player_handler") as PlayerHandler
	
	for card_ui: CardUI in player_handler.hand.get_children():
		card_ui.card.cost = RNG.instance.randi_range(0, 3)
		card_ui.card = card_ui.card
