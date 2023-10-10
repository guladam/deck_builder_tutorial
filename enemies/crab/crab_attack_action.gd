extends EnemyAction

@export var damage := 7


func perform_action() -> void:
	print("attack this turn")
	if not enemy or not target:
		return
	
	var damage_effect := DamageEffect.new()
	damage_effect.amount = damage
	damage_effect.execute([target])
	Events.enemy_action_completed.emit(enemy)
