extends EnemyAction

@export var block := 4


func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy])
	Events.enemy_action_completed.emit(enemy)
