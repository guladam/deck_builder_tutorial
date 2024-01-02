extends Control


func _on_continue_pressed() -> void:
	print("continue game")


func _on_new_run_pressed() -> void:
	print("start new run") # initially, this is temporary


func _on_exit_pressed() -> void:
	get_tree().quit()
