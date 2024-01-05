extends Card

const EXPOSED_STATUS = preload("res://statuses/exposed.tres")

func apply_effects(targets: Array[Node]) -> void:
	var status_effect := StatusEffect.new()
	var exposed := EXPOSED_STATUS.duplicate()
	exposed.duration = 2
	status_effect.status = exposed
	status_effect.execute(targets)
	
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 3
	damage_effect.sound = sound
	damage_effect.execute(targets)
