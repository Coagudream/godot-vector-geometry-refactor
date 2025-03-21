extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $DetectionRadiu/CollisionShape2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var detection_radiu: Area2D = $DetectionRadiu


@export var icon_center_radius :float:
	set(v):
		icon_center_radius = v



@export var detection_radius:float:
	set(v):
		if not is_node_ready():
			await ready
		detection_radius = v
		collision_shape_2d.shape.radius = detection_radius

var point_target_node :Node2D

func _ready() -> void:
	detection_radiu.area_entered.connect(_on_point_target_entered)
	detection_radiu.area_exited.connect(_on_point_target_exited)
	marker_2d.visible = false


func _on_point_target_entered(area:Area2D) -> void:
	if point_target_node:
		return
	
	point_target_node = area
	marker_2d.visible = true

func _on_point_target_exited(area:Area2D) -> void:
	pass
	#marker_2d.visible = false


func _physics_process(delta: float) -> void:
	for i in detection_radiu.get_overlapping_areas():
		if (i.global_position - self.global_position).length() < (point_target_node.global_position - self.global_position).length():
			point_target_node = i


func _process(delta: float) -> void:
	if not point_target_node:
		return
	
	
	point_target(marker_2d)


func point_target(marker_2d: Marker2D) -> void:
	
	var pos :Vector2 = (point_target_node.global_position - self.global_position).normalized()
	marker_2d.position = pos * icon_center_radius
	
	marker_2d.rotation = pos.angle()
