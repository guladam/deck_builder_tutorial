extends Card

var base_block := 7
var exhaust_amount := 1


func get_default_tooltip() -> String:
	return tooltip_text % base_block


func get_updated_tooltip(_player_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	return tooltip_text % base_block


func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	var block_effect := BlockEffect.new()
	block_effect.amount = base_block
	block_effect.sound = sound
	block_effect.execute(targets)

	var exhaust_random_effect := ExhaustRandomEffect.new()
	exhaust_random_effect.amount = exhaust_amount
	exhaust_random_effect.execute(targets)
	
