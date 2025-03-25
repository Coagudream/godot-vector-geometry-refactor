class_name Player
extends CharacterBody2D

@onready var group: Node2D = %Group
@onready var player_camera: Camera2D = $PlayerCamera
@onready var collision_shape_2d_2: CollisionShape2D = $Group/Hurtbox/CollisionShape2D2
@onready var hitbox: Hitbox = %Hitbox
@onready var hurtbox: Hurtbox = %Hurtbox


@export var init_player_property: PlayerState

var player_property: PlayerState

#核心相关
var has_connect_core: bool = false

var target_position: Vector2:
	set(v):
		target_position = v
	get:
		if has_connect_core:
			return target_position
		else:
			return get_global_mouse_position()

var direction_vector :Vector2 :
	get() : return Input.get_vector("move_left","move_right","move_up","move_down")

var mouse_postion :Vector2:
	get() : return get_global_mouse_position()

var aim_position :Vector2

func _ready() -> void:
	player_property = init_player_property.return_resource_copy() as PlayerState

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	vector_up(delta)

func _unhandled_input(event: InputEvent) -> void:
	#相机移动插值
	if event is InputEventMouseMotion:
		var half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)


##移动
func is_move(_delta: float) -> void:
	# OK 改为状态机
	velocity = velocity.move_toward(direction_vector * player_property.max_speed , player_property.acc_speed)

##冲刺
func is_sprint() -> void:
	velocity =  direction_vector * player_property.spint_speed


##矢量值回复
func vector_up(delta:float) -> void:
	if has_connect_core:
		player_property.vector += player_property.vector_up_speed*delta


#属性修改系列函数
func take_health(amount:float) -> void:
	player_property.health += amount
	if amount <0:
		Events.request_camera_sharked.emit(20)
		Events.request_injury_flashing.emit()


func take_accspeed(amount:float) -> void:
	player_property.acc_speed += amount

func take_coll_damage(amount:float) -> void:
	player_property.collision_damage += amount
	hurtbox.damage = -player_property.collision_damage
	

func take_max_health(amount:float) -> void:
	player_property.max_health += amount

func take_max_speed(amount:float) -> void:
	player_property.max_speed += amount
	
func take_max_vector(amount:float) -> void:
	player_property.max_vector += amount
	
func take_vector(amount:float) -> void:
	player_property.vector += amount
	
func take_vector_spend(amount:float) -> void:
	player_property.vector_spend += amount
	
func take_vector_up(amount:float) -> void:
	player_property.vector_up_speed += amount

func take_exp(amount:float) -> void:
	player_property.exps += amount
