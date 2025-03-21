extends Node

@onready var target: Node = $"../Character_property"
@onready var buff_design: Node = $BuffDesign
@onready var buff_handle: BuffHandle = $BuffHandle

func _ready() -> void:
	#确定target和调用add_child方法即可
	buff_design.target = target
	buff_handle.add_buff(buff_design)
