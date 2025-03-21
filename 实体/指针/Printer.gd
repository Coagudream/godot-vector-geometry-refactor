class_name Printer
extends Line2D

@onready var line_area: Area2D = $LineArea
@onready var line_collision: CollisionShape2D = $LineArea/LineCollision

@export var vector_down :float
@export var target_position :Vector2 = Vector2(0.0,0.0)

# BUG 这个有BUG，无法实时更新碰撞数组，初步判是剑杆物理引擎的问题
var contact_area:Array[Area2D]


func _process(_delta: float) -> void:
	#print("指针" ,contact_area)
	set_point_position(1,target_position)
	line_collision.shape.b = target_position

func _physics_process(_delta: float) -> void:
	contact_area = line_area.get_overlapping_areas()
