extends Control


func _on_back_button_pressed() -> void:
	Events.shop_exited.emit()
