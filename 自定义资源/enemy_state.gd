class_name EnemyState
extends CharacterState



@export_group("敌人类型")
enum Type{ordinary,elite,boss}
@export var type :Type

@export_group("敌人图像")
@export var enemy_sprite:Texture2D

@export_group("速度")
@export var max_speed :float = 300.0
@export var min_speed :float = 0.0
@export var acc_speed :float = 75.0

@export_group("碰撞伤害")
@export var is_collision_damage:bool = false
@export var collision_damage:float = 5

@export_group("追踪目标")
enum Target{to_player,to_core,random}
@export var taregt_count :Target:
	set(v):
		taregt_count = v
		Enemystate_changed.emit()

signal Enemystate_changed

var health :float:
	set(v):
		health = v
		Enemystate_changed.emit()

func return_resource_copy() -> Resource:
	var copy_resource : Resource = self.duplicate()
	copy_resource.health = max_health
	return copy_resource
