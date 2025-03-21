class_name UpCardManager
extends HBoxContainer

const UP_CARD = preload("res://升级选择/玩家升级卡牌/up_card.tscn")
const UpCardAmount:int = 3

var player:Player

var all_resource:Dictionary[String,String] = {
	"speed" : "res://升级选择/具体卡牌/speed_up.tres",
	"damage" : "res://升级选择/具体卡牌/damage_up.tres",
	"max_pass_body" : "res://升级选择/具体卡牌/max_pass_up.tres"
}

func _ready() -> void:
	Events.requset_show_card_manager.connect(show_card_group)
	Events.requset_hide_card_manager.connect(hide_card_group)
	
	player = get_tree().get_first_node_in_group("Player")

##展示玩家升级卡牌
func show_card_group() -> void:
	init()
	show()

##隐藏玩家升级卡牌
func hide_card_group() -> void:
	hide()

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
	return play_up_resource
	
