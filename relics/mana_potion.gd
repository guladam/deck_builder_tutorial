extends Relic


func activate_relic(owner: RelicUI) -> void:
	Events.player_hand_drawn.connect(_add_mana.bind(owner), CONNECT_ONE_SHOT)


func _add_mana(owner: RelicUI) -> void:
	var player := owner.get_tree().get_first_node_in_group("player") as Player
	if player:
		player.stats.mana += 1
		owner.flash()
