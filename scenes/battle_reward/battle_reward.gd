extends Control


func _on_back_button_pressed() -> void:
	Events.battle_reward_exited.emit()
