@tool
class_name Boundary
extends StaticBody2D

@onready var area: CollisionShape2D = $Area

@export var color_rect: ColorRect

@export var thickness :Vector2 = Vector2(20.0,20.0):
	set(v):
		thickness = v
		
		if not is_node_ready():
			await ready
		
		_change_color()

func _change_color() -> void:
	if not color_rect:
		return
	
	area.shape.size = thickness
	color_rect.position = -thickness/2
	color_rect.size = thickness
