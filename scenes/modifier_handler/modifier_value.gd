class_name ModifierValue
extends Node

enum Type {PERCENT_BASED, FLAT}

@export var type: Type
@export var percent_value: float
@export var flat_value: int
@export var source: String


static func create_new_modifier(modifier_source: String, what_type: Type) -> ModifierValue:
	var new_modifier := new()
	new_modifier.source = modifier_source
	new_modifier.type = what_type
	
	return new_modifier
