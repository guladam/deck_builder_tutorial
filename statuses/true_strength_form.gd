class_name TrueStrengthStatus
extends Status

const MUSCLE_STATUS = preload("res://statuses/muscle.tres")


func apply_status(target: Node) -> void:
	var status_effect := StatusEffect.new()
	var muscle := MUSCLE_STATUS.duplicate()
	muscle.stacks = 2
	status_effect.status = muscle
	status_effect.execute([target])
	
	status_applied.emit(self)

