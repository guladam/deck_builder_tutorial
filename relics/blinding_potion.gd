extends Relic


func initialize_relic(owner: RelicUI) -> void:
	var run := owner.get_tree().get_first_node_in_group("run") as Run
	run.character.max_mana += 1
	run.character.mana = run.character.max_mana


func activate_relic(owner: RelicUI) -> void:
	owner.get_tree().call_group("intent", "set", "modulate", Color.TRANSPARENT)


func deactivate_relic(owner: RelicUI) -> void:
	print("woohoo")
	var run := owner.get_tree().get_first_node_in_group("run") as Run
	run.character.max_mana -= 1
