extends Control


func _on_back_button_pressed() -> void:
	Events.campfire_exited.emit()
