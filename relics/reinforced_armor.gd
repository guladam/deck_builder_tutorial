extends Relic


func activate_relic(owner: RelicUI) -> void:
	var player := owner.get_tree().get_nodes_in_group("player")
	var block_effect := BlockEffect.new()
	block_effect.amount = 3
	block_effect.execute(player)
	
	owner.flash()
