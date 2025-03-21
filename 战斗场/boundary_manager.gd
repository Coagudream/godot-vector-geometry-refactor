extends Node2D

@onready var down: Boundary = $Down
@onready var left: Boundary = $Left
@onready var right: Boundary = $Right
@onready var up: Boundary = $Up

const INIT_RECT_POSITION :Vector2 = Vector2(-3000.0,-1717.0)
const INIT_RECT_END :Vector2 = Vector2(3000.0,1717.0)
const INIT_RECT_SIZE :Vector2 = Vector2(6000.0,3434.0)


##当前地图边界的矩形
var rect: Rect2 :
	set(v):
		rect = v
		if not rect:
			return
		
		if not is_node_ready():
			await ready
		
		Events.game_boundary_changed.emit(rect)

##初始化
func _ready() -> void:
	rect = Rect2(INIT_RECT_POSITION,INIT_RECT_SIZE)


##移动全部边界（+/-表示边界方向）（正扩负缩）（事件）
func move_boundary(move_distance:float,time:float) -> void:
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(up,"global_position",Vector2(up.global_position.x,up.global_position.y-move_distance),time)
	tween.tween_property(down,"global_position",Vector2(down.global_position.x,down.global_position.y +move_distance),time)
	tween.tween_property(left,"global_position",Vector2(left.global_position.x-move_distance,left.global_position.y),time)
	tween.tween_property(right,"global_position",Vector2(right.global_position.x+move_distance,left.global_position.y),time)
	
	rect = rect.grow(move_distance)
