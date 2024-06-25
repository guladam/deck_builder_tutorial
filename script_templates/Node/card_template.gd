# meta-name: Card Logic
# meta-description: What happens when a card is played.
extends Card

@export var optional_sound: AudioStream


func get_default_tooltip() -> String:
	return tooltip_text


func get_updated_tooltip(_player_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String: # step 7.1
	return tooltip_text


func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	print("My awesome card has been played!")
	print("Targets: %s" % targets)
