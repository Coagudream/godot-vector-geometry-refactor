class_name ItemS
extends Resource

@export_group("名称")
@export var name:String

@export_group("图标")
@export var icon:Texture2D

@export_group("简介")
@export_multiline var tooltip:String

@export_group("排名")
enum Type {common,rare,fine,epic,legendary}
@export var type:Type

@export_group("花费")
@export var gam_stone_spend:int

func apply_effect(_nodes:Array[Node]):
	pass
