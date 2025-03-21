extends CanvasLayer

@onready var red_sprite: ColorRect = $RedSprite

var is_low_blood:bool

func _ready() -> void:
	red_sprite.visible = false
	Events.request_injury_flashing.connect(injury_flashing)
	Events.request_low_blood_volume_warning_start.connect(low_blood_volume_warning_start)
	Events.request_low_blood_volume_warning_exit.connect(low_blood_volume_warning_exit)


##受伤红闪
func injury_flashing(flash_time:float = 0.1) -> void:
	if is_low_blood:
		return
	red_sprite.visible = true
	var tween :Tween = create_tween()
	red_sprite.material.set_shader_parameter("border_width",0.03)
	red_sprite.material.set_shader_parameter("flash_speed",0.1)
	red_sprite.material.set_shader_parameter("flash_intensity",0.3)
	tween.tween_method(_color_red_alpha_changed,0.0,1.0,flash_time)
	tween.tween_method(_color_red_alpha_changed,1.0,0.0,flash_time)
	tween.finished.connect(func(): red_sprite.visible = false)


##低血量预警开始
func low_blood_volume_warning_start() -> void:
	# TODO 渐进式加速/加宽 等等
	is_low_blood = true
	red_sprite.visible = true
	var tween :Tween = create_tween()
	tween.tween_method(_color_red_alpha_changed,0.0,1.0,0.2)
	red_sprite.material.set_shader_parameter("border_width",0.1)
	red_sprite.material.set_shader_parameter("flash_speed",4.5)



##低血量预警结束
func low_blood_volume_warning_exit() -> void:
	var tween :Tween = create_tween()
	tween.tween_method(_color_red_alpha_changed,1.0,0.0,0.2)
	tween.tween_callback(func(): red_sprite.visible = false)
	is_low_blood = false


##alpha通道变换接口
func _color_red_alpha_changed(amount:float) -> void:
	red_sprite.material.set_shader_parameter("border_color",Color(1.0,0.0,0.0,amount))


##颜色变换接口
func _color_changed(color:Color) -> void:
	red_sprite.material.set_shader_parameter("border_color",color)
