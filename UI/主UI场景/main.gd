extends Control


func _on_game_start_pressed() -> void:
	SceneSystem.from_old_to_new_sences("main_ui","world")


func _on_game_continue_pressed() -> void:
	pass # Replace with function body.


func _on_game_map_key_pressed() -> void:
	pass # Replace with function body.

func _on_game_set_pressed() -> void:
	pass # Replace with function body.


func _on_game_quit_pressed() -> void:
	get_tree().quit()
