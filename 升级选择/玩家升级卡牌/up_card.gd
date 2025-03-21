class_name UpCard
extends PanelContainer

@onready var icon: TextureRect = %Icon
@onready var item_tooltip: RichTextLabel = %ItemTooltip

@export var player_up: PlayerUp:
	set(v):
		player_up = v
		if not is_node_ready():
			await ready
		player_up.set_var()
		icon.texture = player_up.icon
		item_tooltip.text = player_up.tooltip

var player:Player
var is_sick:bool = false

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left") and not is_sick:
		var arr_player :Array[Node] = [player]
		player_up.apply_effect(arr_player)
		is_sick = true
		die()

func die() -> void:
	Events.requset_hide_card_manager.emit()
	queue_free()
