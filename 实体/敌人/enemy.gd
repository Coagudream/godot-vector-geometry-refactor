class_name Enemy
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var hitbox: Hitbox = $Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox

@export var enemy :EnemyState

var player:Player
var core:CoreS
var enemy_property :EnemyState

var target_position :Vector2:
	get():
		if enemy_property.taregt_count == EnemyState.Target.to_player:
			return player.global_position
		else:
			return core.global_position


func _ready() -> void:
	enemy_property = enemy.return_resource_copy() as EnemyState
	
	sprite_2d.texture = enemy_property.enemy_sprite
	
	if enemy_property.is_collision_damage:
		hurtbox.damage = -enemy_property.collision_damage
		hurtbox.monitoring = true
	
	player = get_tree().get_first_node_in_group("Player")
	core = get_tree().get_first_node_in_group("Core")
	
	enemy_property.Enemystate_changed.connect(up_data)
	taregt_count_select(enemy_property.taregt_count)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	move(target_position)

##随机选择目标
func taregt_count_select(target:EnemyState.Target) -> void:
	match target:
		EnemyState.Target.to_player:
			enemy_property.taregt_count = 0
		EnemyState.Target.to_core:
			enemy_property.taregt_count = 1
		EnemyState.Target.random:
			enemy_property.taregt_count = randi_range(0,1)


##根据目标设置敌人碰撞层
func changed_collision_layer() -> void:
	if enemy_property.taregt_count == EnemyState.Target.to_player:
		self.set_collision_mask_value(9,false)
	elif enemy_property.taregt_count == EnemyState.Target.to_core:
		self.set_collision_mask_value(3,false)


##移动
func move(target_oaition:Vector2) -> void:
	var direction_vector :Vector2 =  (target_oaition - self.global_position).normalized() 
	velocity = velocity.move_toward(direction_vector * enemy_property.max_speed , enemy_property.acc_speed)


##敌人状态更新
func up_data() -> void:
	label.text = str(enemy_property.health)
	changed_collision_layer()
	
	if enemy_property.health <=0:
		died()

##死亡处理
func died() -> void:
	add_player_exps()
	queue_free()


##效果
func feedback() -> void:
	Events.request_camera_sharked.emit(20)
	
	var filcker = Flicker.new()
	filcker.flicker(self,2.0,2,0.1)
	
	var shark = Sharker.new()
	shark.sharker(self,10)

##玩家经验赋值
func add_player_exps() -> void:
	var arr_player:Array[Node] = [player]
	var new_exps : = ExpEffect.new()
	new_exps.amount = 20
	new_exps.execute(arr_player)




#属性修改

##造成伤害函数
func take_health(amount:float) -> void:
	enemy_property.health += amount
	feedback()

func take_accspeed(amount:float) -> void:
	enemy_property.acc_speed += amount

func take_coll_damage(amount:float) -> void:
	enemy_property.collision_damage += amount

func take_max_health(amount:float) -> void:
	enemy_property.max_health += amount

func take_max_speed(amount:float) -> void:
	enemy_property.max_speed += amount
	
