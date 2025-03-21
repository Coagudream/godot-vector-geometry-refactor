class_name BulletS
extends WeaponS

@onready var bullet_collision: CollisionShape2D = $BulletCollision
@onready var sprite_2d: Sprite2D = $Group/Sprite2D

@export var init_direction : Vector2

var rotate_corrected_value:float = 20
var pass_amount:int = 0

func _ready() -> void:
	super._ready()
	sprite_2d.texture = weapon.icon
	hurtbox.hurted.connect(pass_through)
	fire(init_direction)
	request_buttle_special.connect(buttle_special)
	time_over_bullet()

func _process(delta: float) -> void:
	node_decoration(delta)


func _physics_process(delta: float) -> void:
	move_and_slide()

##子弹消失时间
func time_over_bullet() -> void:
	await get_tree().create_timer(weapon.exist_duration).timeout
	queue_free()

##旋转子弹
func node_decoration(delta:float) -> void:
	var rotate_value:float 
	rotate_value += delta * rotate_corrected_value
	group.rotate(rotate_value)


##子弹发射，设置初始位置
func fire(direction:Vector2) -> void:
	if not direction:
		queue_free()
	velocity = direction * weapon.buttle_speed

##子弹击中hitbox的特效
func buttle_special() -> void:
	if weapon.special:
		var new_special = weapon.special.instantiate()
		new_special.global_position = self.global_position
		get_tree().root.add_child(new_special)

##子弹最大穿过数处理
func pass_through() -> void:
	pass_amount += 1
	request_buttle_special.emit()
	if pass_amount >= weapon.max_pass_body:
		die()

##设置子弹缩放
func _set_scale(multiple:float)  -> void:
	var new_scale :Vector2 = Vector2 (multiple,multiple)
	self.scale = new_scale
