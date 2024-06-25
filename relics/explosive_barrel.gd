extends Relic

@export var damage := 2


func activate_relic(owner: RelicUI) -> void:
	var enemies := owner.get_tree().get_nodes_in_group("enemies")
	var damage_effect := DamageEffect.new()
	damage_effect.amount = damage
	damage_effect.receiver_modifier_type = Modifier.Type.NO_MODIFIER
	damage_effect.execute(enemies)
	
	owner.flash()
