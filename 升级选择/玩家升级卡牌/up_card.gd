class_name UpCard
extends PanelContainer

@onready var icon: TextureRect = %Icon
@onready var item_tooltip: RichTextLabel = %ItemTooltip

const COMMON = preload("res://升级选择/玩家升级卡牌/common.tres")
const EPIC = preload("res://升级选择/玩家升级卡牌/epic.tres")
const FINE = preload("res://升级选择/玩家升级卡牌/fine.tres")
const LEGENDARY = preload("res://升级选择/玩家升级卡牌/legendary.tres")
const RARE = preload("res://升级选择/玩家升级卡牌/rare.tres")

@export var player_up: PlayerUp:
	set(v):
		player_up = v
		if not is_node_ready():
			await ready
		player_up.set_var()
		icon.texture = player_up.icon
		item_tooltip.text = player_up.tooltip
		change_outline_color(player_up)

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

func change_outline_color(card_type:PlayerUp) -> void:
	match card_type.type:
		PlayerUp.Type.common:
			set("theme_override_styles/panel",COMMON)
		PlayerUp.Type.rare:
			set("theme_override_styles/panel",RARE)
		PlayerUp.Type.fine:
			set("theme_override_styles/panel",FINE)
		PlayerUp.Type.epic:
			set("theme_override_styles/panel",EPIC)
		PlayerUp.Type.legendary:
			set("theme_override_styles/panel",LEGENDARY)
	
