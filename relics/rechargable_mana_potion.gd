extends Relic


func activate_relic(owner: RelicUI) -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn.bind(owner), CONNECT_ONE_SHOT)


func _on_player_hand_drawn(owner: RelicUI) -> void:
	owner.flash()
	var player := owner.get_tree().get_first_node_in_group("player") as Player
	player.stats.mana += 1
