extends Node2D

@onready var water_polygon: Polygon2D = $WaterPolygon
@onready var water_border: SmoothPath = $WaterBorder

@export_group("单一波动参数")
@export var k :float = 0.015
@export var d :float = 0.03
@export var spread :float = 0.2

@export_group("波动点的改变")
@export var distance_between_springs: int = 32  ##波动点间距
@export var spring_number: int = 6  ##波动点的数量

@export_group("水体")
@export var depth:float = 1000
var target_height: float = global_position.y
var bottom = target_height + depth

@export_group("平滑处理")
@export var borad_thickness :float = 1.1
@export var spline_length : float = 5.0

var springs : Array[VibrationPoint]
var passes :int = 12

const FLUCTUATE_DROP = preload("res://通用/波动外观/水面波动/波动点/fluctuate_drop.tscn")

func _ready() -> void:
	water_border.width = borad_thickness
	water_border.spline_length = spline_length
	
	spread = spread /1000
	for i in range(spring_number):
		var x_position = distance_between_springs * i
		var new_spring := FLUCTUATE_DROP.instantiate() as VibrationPoint
		add_child(new_spring)
		springs.append(new_spring)
		new_spring.initalize(x_position,i)
		new_spring.set_collision_width(distance_between_springs)
		new_spring.splash.connect(splash)

func _physics_process(delta: float) -> void:
	for i:VibrationPoint in springs:
		i.up_data_state(k,d)
	
	var left_deltas :Array[float] = []
	var right_deltas :Array[float] = []
	
	for i in range(springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		
		
	for j in range(passes):
		for i in range(springs.size()):
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size()-1:
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
	
	new_border()
	draw_water_body()


func splash(index:float,speed:float) -> void:
	
	if index >= 0 and index < springs.size():                                                              
		springs[index].velocity += speed

func draw_water_body():
	
	var curve = water_border.curve
	
	var points :Array = Array(curve.get_baked_points())
	
	var water_polygin_phints :Array = points
	
	var first_index :int = 0
	var last_index = water_polygin_phints.size() - 1
	  
	water_polygin_phints.append(Vector2(water_polygin_phints[last_index].x,bottom))
	water_polygin_phints.append(Vector2(water_polygin_phints[first_index].x,bottom))
	
	water_polygin_phints = PackedVector2Array(water_polygin_phints)
	water_polygon.polygon = water_polygin_phints

func new_border() -> void:
	var curve = Curve2D.new().duplicate()
	var surface_points :Array[Vector2]= []
	
	for spring in springs:
		surface_points.append(spring.position)
	
	for point in surface_points:
		curve.add_point(point)
	
	water_border.curve = curve
	water_border.smooth = true
	water_border.queue_redraw()
