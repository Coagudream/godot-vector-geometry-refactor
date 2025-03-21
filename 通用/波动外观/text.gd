extends CharacterBody2D


#运动影响因子
var motion :Vector2 = Vector2(0,200)

func _physics_process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
