class_name PlayerState
extends CharacterState
# TODO 改成资源

#头像加载

@export_group("头像")
@export var sprite_2d: Texture2D

@export_group("速度相关")
@export var acc_speed :float
@export var max_speed : float
@export var spint_speed :float


@export_group("等级相关")
@export var max_exp :float = 100.0

@export_group("矢量值相关")
@export var vector_up_speed :float = 5
@export var vector_spend :float = 1
@export var max_vector :float = 100

@export_group("碰撞伤害")
@export var collision_damage :float = 100

signal PlayerState_changed

#生命值系统
var health :float :
	set(v):
		health = clampf(v,0,max_health)
		PlayerState_changed.emit()
		# TODO 设置渐变值
		if health/max_health <= 0.3:
			Events.request_low_blood_volume_warning_start.emit()
		if health/max_health >= 0.3:
			Events.request_low_blood_volume_warning_exit.emit()

#等级系统
# BUG exps无法保存，每次升级后都会清零
var exps:float:
	set(v):
		exps = v
		if exps >= max_exp:
			exps = 0
			lv += 1
			max_exp += 5*log(lv+1)
		PlayerState_changed.emit()
var lv:int:
	set(v):
		lv = v
		PlayerState_changed.emit()
		Events.player_lv_up.emit()


#矢量值系统
var vector :float :
	set(v):
		vector = clampf(v,0,max_vector)
		
		PlayerState_changed.emit()


func return_resource_copy() -> Resource:
	var copy_resource : Resource = self.duplicate()
	copy_resource.health = max_health
	copy_resource.exps = 0
	copy_resource.lv = 1
	copy_resource.vector = 0
	
	return copy_resource
