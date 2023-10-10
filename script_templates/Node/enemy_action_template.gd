# meta-name: EnemyAction
# meta-description: An action which can be performed by an enemy during its turn.
extends EnemyAction

@export var export_variable := 4


func perform_action() -> void:
	if not enemy or not target:
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	
	print("Do my awesome action with a number %s!" % export_variable)

	Events.enemy_action_completed.emit(enemy)
