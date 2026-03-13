extends Player 

@onready var label: Label = $Label
@onready var square_collision: CollisionShape2D = $SquareCollision
@onready var square_fire_point: SquareFirePoint = $SquareFirePoint

var state_name :String
var weapon :Weapon
var pointer :Printer

const POINTER = preload("res://实体/指针/Pointer.tscn")

func _ready() -> void:
	super._ready()
	#添加指针
	pointer = POINTER.instantiate() as Printer
	add_child(pointer)
	weapon = square_fire_point.bullet



func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	#选择封装是因为不同角色有不同花费vector的方法
	if Input.is_action_pressed("mouse_right"):
		player_property.vector -= player_property.vector_spend*delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right"):
		take_attack_interval(-0.5)
	
	if event.is_action_released("mouse_right"):
		take_attack_interval(0.5)



func _process(delta: float) -> void:
	super._process(delta)
	label.text = state_name
	look_at_mouse_position(target_position)


func look_at_mouse_position(look_at_position:Vector2) -> void:
	pointer.target_position = look_at_position - global_position
	group.look_at(look_at_position)
	square_collision.look_at(look_at_position)

#修改属性
func take_damage(amount:float) ->void:
	weapon.take_damage(amount)

func take_bullet_speed(amount:float) -> void:
	weapon.take_bullet_speed(amount)
	
func take_max_pass_body(amount:int) -> void:
	weapon.take_max_pass_body(amount)

##设置攻击间隔
func take_attack_interval(amount:float) -> void:
	square_fire_point.take_attack_interval(amount)
