class_name ExhaustRandomEffect
extends Effect

var amount := 1


func execute(targets: Array[Node]) -> void:
	if targets.is_empty():
		return
		
	var player_handler := targets[0].get_tree().get_first_node_in_group("player_handler") as PlayerHandler
	
	if not player_handler:
		return
	
	var hand_randomized := player_handler.hand.get_children().duplicate()
	RNG.array_shuffle(hand_randomized)
	var cards := hand_randomized.slice(0, amount)
	
	for card in cards:
		card.queue_free()
