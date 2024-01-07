class_name ModifierHandler
extends Node


func get_modifier(type: Modifier.Type) -> Modifier:
	for modifier: Modifier in get_children():
		if modifier.type == type:
			return modifier
			
	return null


func get_modified_value(base: int, type: Modifier.Type) -> int:
	var modifier := get_modifier(type)
	
	if not modifier:
		return base
		
	return modifier.get_modified_value(base)
