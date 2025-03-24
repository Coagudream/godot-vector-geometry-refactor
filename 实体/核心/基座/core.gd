class_name CoreS
extends StaticBody2D

enum STATE {no_select,selected}

@onready var item: AnimatedSprite2D = %Item
@onready var base: AnimatedSprite2D = $Group/Base
@onready var round_circle: Round = $Round

@export var core_resource :Core:
	set(v):
		if not is_node_ready():
			await ready
		core_resource = v
		#动画名称要和Item内的名称配合起来
		player_item(core_resource.anim_name)

@export var round_radius :float = 500.0
@export var max_health :float = 500.0
@export var max_lv: int = 10

var max_exp:float = 100.0
var current_state :STATE
var player:Player

var health:float :
	set(v):
		health = clampf(v,0,max_health)
		if health <= 0:
			broken()
			restore()

var lv:int:
	set(v):
		lv = clampi(v,0,max_lv)
		Events.core_lv_up.emit(lv)

var exps:float:
	set(v):
		exps = v
		if exps >= max_exp:
			lv += 1
			exps = 0.0
		# TODO 思考是不是有破限选项
		if lv == max_lv:
			return


func _ready() -> void:
	health = max_health
	current_state = STATE.no_select
	player = get_tree().get_first_node_in_group("Player")
	Events.requset_core_inning_start.connect(core_start)

func _process(_delta: float) -> void:
	round_circle.move_radius()

func _physics_process(_delta: float) -> void:
	if not core_resource:
		return
	if current_state == STATE.selected and core_resource.permanent:
		_on_apply_core()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left") and current_state == STATE.selected:
		if player.player_property.vector >= player.player_property.vector_spend :
			var tween:Tween = create_tween()
			player.player_property.vector -= player.player_property.vector_spend
			tween.tween_property(player,"global_position",round_circle.get_move_radius(),0.3).set_trans(Tween.TRANS_CUBIC)

##播放动画
func player_item(anim_name:String) -> void:
	if not core_resource:
		return
	
	item.play(anim_name)


# TODO 回合开始时接入
##回合开始时，核心处理函数
func core_start() -> void:
	if not player:
		print("Core没有找到Player")
		return
	
	current_state = STATE.selected
	_on_core_hdr()
	has_selected()


##回合退出
func core_exit() -> void:
	current_state = STATE.no_select
	_on_core_hdr()
	no_selected()


##核心HDR变化
func _on_core_hdr() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(base,"self_modulate",Color(3.0,3.0,3.0,1.0),0.7)
	tween.tween_property(base,"self_modulate",Color(1.0,1.0,1.0,1.0),0.7)

##核心破碎函数
func broken() -> void:
	pass


##核心破碎后的恢复函数
func restore() -> void:
	pass


##退出选中函数
func no_selected() -> void:
	Events.request_camera_sharked.emit(250)
	round_circle.target_position = Vector2(0.0,0.0)
	round_circle.visible = false
	player.pointer.texture = null
	player.has_connect_core = false

##选中函数
func has_selected() -> void:
	Events.request_camera_sharked.emit(250)
	round_circle.target_position = Vector2(round_radius,0.0)
	round_circle.visible = true
	player.has_connect_core = true
	player.target_position = self.global_position
	_on_apply_core()


##效果函数
func _on_apply_core() -> void:
	if not core_resource:
		return
	player.pointer.texture =  core_resource.pointer_icon
	#可以修改这个值，如通过组获取全体敌人or玩家
	var arr_player :Array[Node] = [player]
	core_resource.apply_core(arr_player)


#属性修改系列函数
func take_health(amount:float) -> void:
	health += amount

func take_max_health(amount:float) -> void:
	max_health += amount
	
func take_exp(amount:float) -> void:
	exps += amount
