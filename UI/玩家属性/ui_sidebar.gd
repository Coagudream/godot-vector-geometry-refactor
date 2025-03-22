extends PanelContainer

@onready var property_field: VBoxContainer = %PropertyField

@onready var max_health: Label = $PropertyField/MaxHealth
@onready var coll_damage: Label = $PropertyField/CollDamage
@onready var acc_speed: Label = $PropertyField/AccSpeed
@onready var max_speed: Label = $PropertyField/MaxSpeed
@onready var max_vector: Label = $PropertyField/MaxVector
@onready var vector_up: Label = $PropertyField/VectorUp
@onready var vector_spend: Label = $PropertyField/VectorSpend

@onready var damage: Label = $PropertyField/Damage
@onready var max_pass_body: Label = $PropertyField/MaxPassBody
@onready var duation: Label = $PropertyField/Duation
@onready var bullet_speed: Label = $PropertyField/BulletSpeed

@export var playerstate:PlayerState:
	set(v):
		playerstate = v
		
		if not is_node_ready():
			await ready
		if not playerstate.PlayerState_changed.is_connected(_up_player_data_ui_data):
			playerstate.PlayerState_changed.connect(_up_player_data_ui_data)
			
		_up_player_data_ui_data()

@export var weaponstate:Weapon:
	set(v):
		weaponstate = v
		
		if not is_node_ready():
			await ready
		
		if not weaponstate.weapon_state_changes.is_connected(_up_weapon_data_ui_data):
			weaponstate.weapon_state_changes.connect(_up_weapon_data_ui_data)
			
		_up_weapon_data_ui_data()

func _ready() -> void:
	var player := get_tree().get_first_node_in_group("Player")
	if not player:
		return
	playerstate = player.player_property
	weaponstate = player.weapon
	#改成一般形态

func _up_player_data_ui_data() -> void:
	max_health.text = "最大生命：%s" %playerstate.max_health
	acc_speed.text = "加速度：%s" %playerstate.acc_speed
	max_speed.text = "最大速度：%s" %playerstate.max_speed
	max_vector.text = "最大矢量：%s" %playerstate.max_vector
	vector_up.text = "矢量回复：%s" %playerstate.vector_up_speed
	vector_spend.text = "矢量消耗：%s" %playerstate.vector_spend
	coll_damage.text = "接触伤害：%s" %playerstate.collision_damage
func _up_weapon_data_ui_data() -> void:
	if weaponstate is Bullet:
		damage.text = "伤害：%s" %weaponstate.damage
		max_pass_body.text = "穿过数：%s" %weaponstate.max_pass_body
		bullet_speed.text = "弹速：%s" %weaponstate.buttle_speed
		duation.text = "间隔时间：%s" %weaponstate._attack_interval
