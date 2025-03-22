extends Control

@onready var square: Player = $"../../Square"

func _on_button_pressed() -> void:
	Events.request_next_round_start.emit()


func _on_button_2_pressed() -> void:
	Events.requset_show_card_manager.emit()


func _on_button_3_pressed() -> void:
	square.take_exp(200)


func _on_button_4_pressed() -> void:
	Events.requesr_round_events.emit()
