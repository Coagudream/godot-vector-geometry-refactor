class_name BuffDesign
extends MarginContainer

@onready var icon: TextureRect = %Icon
@onready var storey: Label = %Storey

@export var buff_data :BuffData ##Buff数据


#这三个变量在添加时（BuffHandle）管理
var duratio_time :float     ##Buff当前持续时间 
var tick_time :float       ##Buff当前每秒持续时间
var cur_stack :int :         ##Buff当前层数
	set(v):
		cur_stack = v
		storey.text = str(cur_stack)


#class BuffInfo:
var target :Node   ##Buff目标
var creator :Node  ##Buff发出者

#class DamageInfo:
var damage_target :Node   ##Buff目标
var damage_creator :Node  ##Buff发出者


var damage :float  ##伤害


func _ready() -> void:
	if not buff_data :
		return
	
	if buff_data.need_icon:
		icon.texture = buff_data.icon
	
	storey.text = ""
