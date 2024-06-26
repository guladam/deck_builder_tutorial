extends Relic

var already_initialized := false


func initialize_relic(owner: RelicUI) -> void:
	# makes sure we don't have extra mana when we
	# keep saving and loading the game
	if already_initialized:
		return

	var run := owner.get_tree().get_first_node_in_group("run") as Run
	run.character.max_mana += 1
	run.character.mana = run.character.max_mana
	already_initialized = true


func activate_relic(owner: RelicUI) -> void:
	owner.get_tree().call_group("intent", "set", "modulate", Color.TRANSPARENT)


func deactivate_relic(owner: RelicUI) -> void:
	var run := owner.get_tree().get_first_node_in_group("run") as Run
	run.character.max_mana -= 1
