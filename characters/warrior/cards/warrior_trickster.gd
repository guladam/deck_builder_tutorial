extends Card

var base_block := 2


func get_default_tooltip() -> String:
	return tooltip_text % base_block


func get_updated_tooltip(_player_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	return tooltip_text % base_block


func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	var block_effect := BlockEffect.new()
	block_effect.amount = base_block
	block_effect.sound = sound
	block_effect.execute(targets)

	var card_draw_effect := CardDrawEffect.new()
	card_draw_effect.cards_to_draw = 1
	card_draw_effect.execute(targets)
