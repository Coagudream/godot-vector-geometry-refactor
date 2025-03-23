class_name GemStone
extends Sprite2D

var run_state:RunState

func _ready() -> void:
	if not is_node_ready():
		await ready
	run_state = get_tree().get_first_node_in_group("RunState")

func _on_area_2d_body_entered(body: Node2D) -> void:
	run_state.run_state_.gem_amount += randi_range(1,5)
	queue_free()
