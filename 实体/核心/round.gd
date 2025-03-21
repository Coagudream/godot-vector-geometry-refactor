class_name Round
extends Node2D

const EFFOCT:float = 33

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2

##设置半径目标位置
var target_position: Vector2:
	set(v):
		target_position = v
		_set_radius()

func _ready() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	sprite_2d_2.rotation += delta

##设置半径
func _set_radius(expand_time:float = 0.25) -> void:
	var tween :Tween = create_tween()
	var radius :float = (global_position - target_position).length()
	var new_scale = radius / (100 - EFFOCT)
	
	tween.parallel().tween_property(sprite_2d,"scale",Vector2(new_scale,new_scale),expand_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_method(_set_shader_ring_width,0.005,0.0015,expand_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)


##获取移动坐标
func get_move_radius() -> Vector2:
	return sprite_2d_2.global_position
	
##弧线移动
func move_radius() -> void:
	var radius :float = (global_position - target_position).length()
	sprite_2d_2.position = (get_global_mouse_position() - global_position).normalized() * (radius * 100 / (100.0 - EFFOCT))


func _set_shader_ring_width(ring_width:float) -> void:
	sprite_2d.material.set_shader_parameter("ring_width",ring_width)
