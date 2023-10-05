class_name BlockEffect
extends CardEffect

var amount := 0


func execute(targets: Array[Node]) -> void:
	for target in targets:
		if target is Enemy or target is Player:
			target.stats.block += amount
