class_name RoundEventsUI
extends PanelContainer

@onready var label: Label = $VBoxContainer/Label
@onready var up_color: ColorRect = $VBoxContainer/UpColor
@onready var down_color: ColorRect = $VBoxContainer/DownColor

func _ready() -> void:
	Events.round_events_ui.connect(chang_text_and_color)

func chang_text_and_color(prompt:String,grade:EventsManager.GRADE) -> void:
	label.text = prompt
	chang_color(grade)
	ui_show()

##改变颜色
func chang_color(grade:EventsManager.GRADE) -> void:
	match grade:
		EventsManager.GRADE.	Basic:
			up_color.material.set_shader_parameter("color_two",Color.YELLOW)
		EventsManager.GRADE.	Intermediate:
			up_color.material.set_shader_parameter("color_two",Color.ORANGE)
		EventsManager.GRADE.	Advanced:
			up_color.material.set_shader_parameter("color_two",Color.RED)

##ui展示
func ui_show() -> void:
	show()
	var tewwn := create_tween()
	tewwn.tween_property(self,"modulate",Color(1.0,1.0,1.0,1.0),1)
	tewwn.tween_interval(1)
	tewwn.finished.connect(ui_hide)

##ui隐藏
func ui_hide() -> void:
	var tewwn := create_tween()
	tewwn.tween_property(self,"modulate",Color(1.0,1.0,1.0,0.0),1)
	tewwn.tween_interval(1)
	tewwn.finished.connect(hide)		
