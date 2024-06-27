class_name EventRoomButton
extends Button

var event_button_callback: Callable


func _on_pressed() -> void:
	if event_button_callback:
		event_button_callback.call()

	Events.event_room_exited.emit()
