class_name PlayerUp
extends Resource


@export_group("图标")
@export var icon:Texture2D

@export_group("简介")
@export_multiline var tooltip:String

@export_group("排名")
enum Type {common,rare,fine,epic,legendary}
@export var type:Type

var amount :float

func set_var() -> void:
	pass

func apply_effect(_nodes:Array[Node]):
	pass
