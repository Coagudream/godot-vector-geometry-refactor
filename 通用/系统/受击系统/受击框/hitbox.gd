class_name Hitbox extends Area2D

@export var target:Node

func take_damage(damage):
	var targets:Array[Node] = [target]
	
	var attack = HealthEffect.new()
	attack.amount = damage
	attack.execute(targets)
