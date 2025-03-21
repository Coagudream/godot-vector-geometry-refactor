class_name Bullet 
extends Weapon

@export_group("子弹相关")
@export var buttle_speed : float = 0.0:
	set(v):
		buttle_speed = v
		weapon_state_changes.emit()

@export var max_pass_body :int = 1:
	set(v):
		max_pass_body = v
		weapon_state_changes.emit()
		
@export var exist_duration :float = 0.0:
	set(v):
		exist_duration = v
		weapon_state_changes.emit()

var _attack_interval:float:
	set(v):
		_attack_interval = v
		weapon_state_changes.emit()

#修改属性
func take_bullet_speed(amount:float) -> void:
	buttle_speed += amount
func take_max_pass_body(amount:int) -> void:
	max_pass_body += amount


func return_resource_copy() -> Resource:
	var copy_resource : Resource = self.duplicate()
	copy_resource.damage = damage
	copy_resource.max_pass_body = max_pass_body
	copy_resource.buttle_speed = buttle_speed
	copy_resource.exist_duration = exist_duration
	
	return copy_resource
