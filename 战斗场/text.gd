extends Control


func _on_button_pressed() -> void:
	Events.request_next_round_start.emit()


func _on_button_2_pressed() -> void:
	Events.requset_show_card_manager.emit()
