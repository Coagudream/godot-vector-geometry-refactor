class_name UpCardManager
extends HBoxContainer

signal up_card_clicked

const UP_CARD = preload("res://升级选择/玩家升级卡牌/up_card.tscn")
const UpCardAmount:int = 3

var player:Player
var player_lv_up_times :int = 0

##全部的升级卡牌资源
var all_resource:Dictionary[String,String] = {
	"speed" : "res://升级选择/具体卡牌/speed_up.tres",
	"damage" : "res://升级选择/具体卡牌/damage_up.tres",
	"max_pass_body" : "res://升级选择/具体卡牌/max_pass_up.tres"
}



func _ready() -> void:
	Events.player_lv_up.connect(player_lv_up_time)
	Events.round_end.connect(round_end_show_times)
	Events.requset_show_card_manager.connect(show_card_group)
	Events.requset_hide_card_manager.connect(hide_card_group)
	player = get_tree().get_first_node_in_group("Player")

##一回合内的升级次数
func player_lv_up_time() -> void:
	player_lv_up_times += 1

##回合结束展示多少次卡牌(按照升级次数)
func round_end_show_times() -> void:
	for i in range(player_lv_up_times):
		show_card_group()
		await up_card_clicked
	
	player_lv_up_times = 0
	Events.request_show_store.emit()


##展示玩家升级卡牌
func show_card_group() -> void:
	init()
	show()

##隐藏玩家升级卡牌
func hide_card_group() -> void:
	hide()
	up_card_clicked.emit()

##初始化升级卡牌
func init() -> void:
	for child:UpCard in get_children():
		child.queue_free()
	for i in range(UpCardAmount):
		var new_up_card :UpCard = UP_CARD.instantiate()
		new_up_card.player_up = load_resource()
		new_up_card.player = player
		add_child(new_up_card)


func load_resource() -> PlayerUp:
	var random_number:int = randi_range(0,all_resource.size()-1)
	var path :String = all_resource.values()[random_number]
	var play_up_resource:PlayerUp= load(path)
	play_up_resource.type = randi_range(0,4)
	return play_up_resource
