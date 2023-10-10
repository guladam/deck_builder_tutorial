class_name DamageEffect
extends Effect

var amount := 0


func execute(targets: Array[Node]) -> void:
	for target in targets:
		if target is Enemy or target is Player:
			target.take_damage(amount)
