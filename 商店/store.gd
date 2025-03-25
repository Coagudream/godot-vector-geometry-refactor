extends PanelContainer

@onready var items_container: HBoxContainer = %ItemsContainer
@onready var refresh_buuton: Button = %Refresh
@onready var next_round: Button = %NextRound
@onready var gem_amount: Label = %GemAmount
@onready var v_2: PanelContainer = %V2

const ITEMS = preload("res://商店/items.tscn")
const ITEMS_AMOUNT:int = 4

const FIRE_TIME_DOWN = preload("res://实体/道具/fire_time_down.tres")
const COLL_DAMAGE_UP = preload("res://实体/道具/coll_damage_up.tres")


var refresh_gem_amount:int = 20
var refresh_times:int = 1

var item_lock: int
var player:Player
var run_state:RunState:
	set(v):
		run_state = v
		run_state.run_state_.run_updata_cahnged.connect(gam_stone_updata_amount)

func _ready() -> void:
	Events.request_show_store.connect(show_store)
	player = get_tree().get_first_node_in_group("Player")
	run_state = get_tree().get_first_node_in_group("RunState")
	refresh_buuton.pressed.connect(refresh_items)
	refresh_buuton.pressed.connect(refresh_updata)
	refresh_buuton.text = "刷新(%s)" %refresh_gem_amount
	gam_stone_updata_amount()

##展示商店
func show_store() -> void:
	v_2.player = player
	refresh_items()
	show()

##判断能不能买
func can_or_notcan_buy() -> void:
	if not run_state:
		return
	for item in items_container.get_children():
		if item.items.gam_stone_spend > run_state.run_state_.gem_amount:
			item.buy_botton.disabled = true


# BUG 刷新无法及时更新（恢复）按下状态
##能不能按下刷新按钮
func refresh_button_diab() -> void:
	if refresh_gem_amount > run_state.run_state_.gem_amount:
		refresh_buuton.disabled = true

##刷新逻辑更新
func refresh_updata() -> void:
	refresh_buuton.text = "刷新(%s)" %refresh_gem_amount
	refresh_gem_amount += int(25*(log(refresh_times+3)/log(10)))
	refresh_times += 1
	run_state.run_state_.gem_amount -= refresh_gem_amount
	refresh_button_diab()

##刷新道具卡牌
func refresh_items() -> void:
	for child in items_container.get_children():
		if child.is_lock:
			item_lock += 1
			continue
		child.queue_free()
	
	for item in range(ITEMS_AMOUNT - item_lock):
		var new_item := ITEMS.instantiate()
		new_item.items = text_effect()
		new_item.player = player
		new_item.run_state = run_state
		new_item.already_is_buy.connect(can_or_notcan_buy)
		items_container.add_child(new_item)
	can_or_notcan_buy()
	item_lock = 0


func text_effect() -> Resource:
	var amount : int = randi_range(0,1)
	if  amount == 1:
		return FIRE_TIME_DOWN
	else:
		return COLL_DAMAGE_UP
	



##请求下一个回合
func _on_next_round_pressed() -> void:
	Events.request_next_round_start.emit()
	hide()

##更新ui
func gam_stone_updata_amount() -> void:
	gem_amount.text = str(run_state.run_state_.gem_amount)
