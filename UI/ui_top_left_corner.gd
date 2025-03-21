extends VBoxContainer


@onready var icon: TextureRect = %Icon
@onready var hp_bar: TextureProgressBar = %HpBar
@onready var vector_bar: TextureProgressBar = %VectorBar
@onready var exp_bar: TextureProgressBar = %ExpBar
@onready var lv: Label = %Lv

@export var playerstate:PlayerState:
	set(v):
		playerstate = v
		
		if not is_node_ready():
			await ready
		
		if not playerstate.PlayerState_changed.is_connected(_updata_ui_data):
			playerstate.PlayerState_changed.connect(_updata_ui_data)
		
		
		_updata_ui_data()

func _ready() -> void:
	var player :Node = get_tree().get_first_node_in_group("Player")
	if not player:
		return
	playerstate = player.player_property

func _updata_ui_data() -> void:
	icon.texture = playerstate.sprite_2d
	hp_bar.max_value = playerstate.max_health
	exp_bar.max_value = playerstate.max_exp
	vector_bar.max_value = playerstate.max_vector
	hp_bar.value = playerstate.health
	exp_bar.value = playerstate.exps
	vector_bar.value = playerstate.vector
