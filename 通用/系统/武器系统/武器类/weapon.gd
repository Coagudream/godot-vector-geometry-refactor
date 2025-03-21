class_name WeaponS
extends CharacterBody2D

@onready var group: Node2D = %Group
@onready var hurtbox: Hurtbox = %Hurtbox

@export var weapon :Weapon


signal request_buttle_special

func _ready() -> void:
	init_damage(weapon.damage)


func init_damage(amount:float) -> void:
	if not hurtbox:
		return
	hurtbox.damage = -amount

func die() -> void:
	queue_free()
