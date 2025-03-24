class_name Item
extends PanelContainer

@onready var icon: TextureRect = %Icon
@onready var item_tooltip: RichTextLabel = %ItemTooltip
@onready var lock_botton: Button = %Lock
@onready var buy_botton: Button = %Buy
@onready var label: Label = %Label

const COMMON = preload("res://主题/common.tres")
const EPIC = preload("res://主题/epic.tres")
const FINE = preload("res://主题/fine.tres")
const LEGENDARY = preload("res://主题/legendary.tres")
const RARE = preload("res://主题/rare.tres")

signal already_is_buy

@export var items: ItemS:
	set(v):
		items = v
		if not is_node_ready():
			await ready
		icon.texture = items.icon
		item_tooltip.text = items.tooltip
		label.text = items.name
		buy_botton.text = "购买（%s）" %items.gam_stone_spend
		change_outline_color(items)

var player:Player
var run_state:RunState

var is_lock:bool = false

##购买
func _on_buy_pressed() -> void:
	run_state.run_state_.gem_amount -= items.gam_stone_spend
	var arr_player :Array[Node] = [player]
	items.apply_effect(arr_player)
	already_is_buy.emit()
	die()

##锁定
func _on_lock_toggled(toggled_on: bool) -> void:
	is_lock = toggled_on


func change_outline_color(card_type:ItemS) -> void:
	match card_type.type:
		ItemS.Type.common:
			set("theme_override_styles/panel",COMMON)
		ItemS.Type.rare:
			set("theme_override_styles/panel",RARE)
		ItemS.Type.fine:
			set("theme_override_styles/panel",FINE)
		ItemS.Type.epic:
			set("theme_override_styles/panel",EPIC)
		ItemS.Type.legendary:
			set("theme_override_styles/panel",LEGENDARY)


func die() -> void:
	
	queue_free()
