class_name MuscleStatus
extends Status

var player: Player


func apply_status(target: Node) -> void:
	player = target as Player
	status_changed.connect(_on_status_changed)
	_on_status_changed()
	
	status_applied.emit(self)


func _on_status_changed() -> void:
	if not player:
		return
		
	var dmg_dealt_modifier := player.modifier_handler.get_modifier(Modifier.Type.DMG_DEALT)
	
	if not dmg_dealt_modifier:
		return
		
	var muscle_modifier_value := dmg_dealt_modifier.get_value("muscle")
	
	if not muscle_modifier_value:
		muscle_modifier_value = ModifierValue.create_new_modifier("muscle", ModifierValue.Type.FLAT)
		
	muscle_modifier_value.flat_value = stacks
	dmg_dealt_modifier.add_new_value(muscle_modifier_value)
