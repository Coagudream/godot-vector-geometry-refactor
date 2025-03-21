class_name SquareFirePoint
extends Node

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var detection_radiu: Area2D = %Detection
@onready var square_fire_point: Node2D = $"."
@onready var fluctuate: Fluctuate = %Fluctuate
@onready var fire_point_node: Node = $FirePoint


@export var icon_center_radius :float:
	set(v):
		icon_center_radius = v

@export var detection_radius:float:
	set(v):
		if not is_node_ready():
			await ready
		detection_radius = v
		
		_set_radius(detection_radius)

@export var attack_interval:float = 1.0:
	set(v):
		attack_interval = v
		bullet._attack_interval =  attack_interval
		
@export var bullet_resource: Bullet

var fire_point :Array[Vector2]
var is_fire:bool = false
var bullet: Bullet
var in_attack_interval:float = attack_interval

var point_target_node :Node2D
var array_area : Array[Area2D]:
	get(): return detection_radiu.get_overlapping_areas()

#使用子弹场景，分配不同的武器resource，方便ui的更新,不要忘记缩放子弹
const BULLET = preload("res://实体/子弹/bullet.tscn")
const MARKER_2D = preload("res://通用/系统/武器系统/远程/发射器/marker_2d.tscn")

func _ready() -> void:
	bullet = bullet_resource.return_resource_copy()
	bullet._attack_interval =  attack_interval
	marker_visual(false)


func _physics_process(delta: float) -> void:
	await_time_fire(delta)
	
	if array_area.is_empty():
		marker_visual(false)
		return
	
	marker_visual(true)
	point_target_node = array_area[0]
	
	#追踪最近的敌人
	for i in array_area:
		if (i.global_position - self.global_position).length() < (point_target_node.global_position - self.global_position).length():
			point_target_node = i
	fire()


func _process(_delta: float) -> void:
	if not point_target_node:
		return
	for marker_2d in fire_point_node.get_children():
		point_target(marker_2d)

func await_time_fire(delta:float) -> void:
	in_attack_interval -= delta
	if in_attack_interval <= 0 :
		is_fire = true
		in_attack_interval = attack_interval


##开火
func fire() -> void:
	if is_fire and point_target_node:
		
		for child in fire_point_node.get_children():
			var child_pos:Vector2 = child.global_position
			if child is Marker2D:
				fire_point.append(child_pos)
		
		for direction:Vector2 in fire_point:
			var new_square_bullet := BULLET.instantiate()
			new_square_bullet.weapon = bullet
			new_square_bullet.init_direction = (direction - self.global_position).normalized()
			new_square_bullet.global_position = direction
			get_tree().root.add_child(new_square_bullet)
		
		fire_point.clear()
		is_fire = false

##添加射击点
func add_fire_point() -> void:
	var new_marker = MARKER_2D.instantiate()
	fire_point_node.add_child(new_marker)

##make2d 的指向逻辑
func point_target(marker_2d: Marker2D) -> void:
	var pos :Vector2 = (point_target_node.global_position - self.global_position).normalized()
	marker_2d.position = pos * icon_center_radius
	marker_2d.rotation = pos.angle()

##marker 的可见逻辑
func marker_visual(is_visual:bool) -> void:
	for marker_2d in fire_point_node.get_children():
		marker_2d.visible = is_visual

##设置攻击半径ui
func _set_radius(radius:float) -> void:
	collision_shape_2d.shape.radius = radius
	fluctuate._set_radius((radius)*2)

##设置攻击间隔
func take_attack_interval(amount:float) -> void:
	attack_interval += amount
