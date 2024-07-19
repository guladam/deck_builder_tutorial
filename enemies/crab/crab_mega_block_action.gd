extends EnemyAction

@export var block := 15
@export var hp_threshold := 6

var already_used := false


func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	return enemy.stats.health <= hp_threshold


func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	block_effect.execute([enemy])
	already_used = true
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
