class_name CharacterStats
extends Stats

@export var starting_deck: CardPile
@export var max_mana: int

var mana: int : set = set_mana
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile


func set_mana(value: int) -> void:
	mana = value
	stats_changed.emit()


func take_damage(damage: int) -> void:
	super.take_damage(damage)
	Events.player_hit.emit()


func reset_mana() -> void:
	self.mana = max_mana


func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
