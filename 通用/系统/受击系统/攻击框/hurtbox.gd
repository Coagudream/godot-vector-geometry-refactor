class_name Hurtbox extends Area2D

var damage: float

signal hurted

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Hitbox):
	if not area and not area is Hitbox:
		return
	
	area.take_damage(damage)
	
	hurted.emit()
