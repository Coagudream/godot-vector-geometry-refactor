class_name State extends Node

signal update_state(state_name:String)

func enter():
	pass
	
func update(_delta: float):
	#if 状态转换判定条件 :
	#update_state.emit("大写字母")
	pass

	
func physics_update(_delta: float):
	pass
	
	
func exit():
	pass
