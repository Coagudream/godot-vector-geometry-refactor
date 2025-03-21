extends Camera2D

const INIT_RECT_POSITION :Vector2 = Vector2(-3000.0,-1717.0)
const INIT_RECT_END :Vector2 = Vector2(3000.0,1717.0)


@export var player: Player
@export var sensitivity := 0.1

func _ready() -> void:
	Events.request_camera_sharked.connect(_on_camera_shark)
	_init_camera()

func _physics_process(_delta: float) -> void:
	var target_position = player.aim_position * sensitivity
	position = position.lerp(target_position, 0.25)

func _on_camera_shark(strength:float) -> void:
	var new_shark = Sharker.new()
	new_shark.sharker(self,strength)

func _init_camera() -> void:
	var rect:Rect2
	rect.position = INIT_RECT_POSITION
	rect.end = INIT_RECT_END
	_camera_boundary_changed(rect)

func _camera_boundary_changed(rect:Rect2) -> void:
	limit_left = int(rect.position.x)
	limit_top = int(rect.position.y)
	limit_right = int(rect.end.x)
	limit_bottom = int(rect.end.y)
	
