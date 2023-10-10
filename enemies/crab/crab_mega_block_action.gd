extends EnemyAction

@export var block := 15
@export var hp_threshold := 6

var already_used := false


func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low
	
	return is_low


func perform_action() -> void:
	print("megablock this turn")
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy])
	Events.enemy_action_completed.emit(enemy)
