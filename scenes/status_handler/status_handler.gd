class_name StatusHandler
extends GridContainer

const STATUS_UI = preload("res://scenes/status_handler/status_ui.tscn")


func _ready() -> void:
	for child in get_children():
		child.queue_free()
	
	var test := load("res://statuses/exposed.tres")
	await get_tree().create_timer(2).timeout
	add_status(test)
	await get_tree().create_timer(2).timeout
	add_status(test)
	await get_tree().create_timer(2).timeout
	get_status(test.id).apply_status(null)
	await get_tree().create_timer(2).timeout
	get_status(test.id).apply_status(null)


func add_status(status: Status) -> void:
	var stackable := status.stack_type != Status.StackType.NONE
	
	# Add it if it's new
	if not has_status(status.id):
		var new_status_ui: StatusUI = STATUS_UI.instantiate() as StatusUI
		add_child(new_status_ui)
		new_status_ui.status = status
		new_status_ui.status.status_applied.connect(_on_status_applied)
		return

	# If it's unique and we already have it, we can return
	if not status.can_expire and not stackable:
		print("already have this unique status")
		return
	
	# If it's duration-stackable, expand it
	if status.can_expire and status.stack_type == Status.StackType.DURATION:
		get_status(status.id).duration += status.duration
		return
	
	# If it's stackable, stack it
	if status.stack_type == Status.StackType.INTENSITY:
		get_status(status.id).stacks += status.stacks
	

func has_status(id: String) -> bool:
	for status_ui: StatusUI in get_children():
		if status_ui.status.id == id:
			return true
			
	return false


func get_status(id: String) -> Status:
	for status_ui: StatusUI in get_children():
		if status_ui.status.id == id:
			return status_ui.status
	
	return null


func _on_status_applied(status: Status) -> void:
	if status.can_expire:
		status.duration -= 1
