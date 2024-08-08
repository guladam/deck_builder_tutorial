extends EnemyAction

const MUSCLE_STATUS = preload("res://statuses/muscle.tres")

@export var stacks_per_action := 2

var hp_threshold := 25
var usages := 0


func is_performable() -> bool:
	var hp_under_threshold := enemy.stats.health <= hp_threshold
	
	if usages == 0 or (usages == 1 and hp_under_threshold):
		return true
	
	return false


func perform_action() -> void:
	if not enemy or not target:
		return
	
	usages += 1
	var status_effect := StatusEffect.new()
	var muscle := MUSCLE_STATUS.duplicate()
	muscle.stacks = stacks_per_action
	status_effect.status = muscle
	status_effect.execute([enemy])
	
	SFXPlayer.play(sound)

	Events.enemy_action_completed.emit(enemy)
