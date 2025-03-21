class_name Weapon
extends Resource

signal weapon_state_changes

@export_group("伤害")
@export var damage : float = 0.0:
	set(v):
		damage = v
		weapon_state_changes.emit()

@export_group("特效")
@export var special :PackedScene
@export var special_time :float

@export_group("图标")
@export var icon : Texture2D

func return_resource_copy() -> Resource:
	var copy_resource : Resource = self.duplicate()
	copy_resource.damage = damage
	
	return copy_resource

func take_damage(amount:float) -> void:
	damage += amount
