class_name MuscleStatus
extends Status


func apply_status(target: Node) -> void:
	status_changed.connect(_on_status_changed)
	_on_status_changed()
	status_applied.emit(self)


func _on_status_changed() -> void:
	print("Muscle status: +%s damage" % stacks)
