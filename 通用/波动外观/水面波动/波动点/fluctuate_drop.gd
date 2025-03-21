class_name VibrationPoint
extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var velocity :float = 0
var target_height :float =0
var height :float = 0
var force:float =0

var index:int
var motion_factor:float = 0.02
var collided_with = null

signal splash(index:int,speed:int)

func up_data_state(spring_constant:float,dampening:float) -> void:
	height = position.y
	
	var x :float = height - target_height
	var loss :float = -dampening * velocity
	
	force = -spring_constant * x + loss
	
	velocity += force
	
	position.y += velocity

func initalize(x_position:float,id:int) -> void:
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = id
	
func set_collision_width(value) ->void:
	var extents :Vector2 = collision_shape_2d.shape.get_size()
	
	var new_extents :Vector2 = Vector2(value,extents.y)
	
	collision_shape_2d.shape.set_size(new_extents)


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	#if body == collided_with:
		#return 
	#collided_with = body
	
	
	#body的运动影响因子（motion）
	var speed = body.motion.y * motion_factor
	
	splash.emit(index,speed)
