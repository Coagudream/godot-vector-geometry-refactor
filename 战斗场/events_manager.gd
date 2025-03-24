class_name EventsManager
extends Node

@onready var round_manager: RoundManager = %RoundManager
@onready var enemy_manager: EnemyManager = %EnemyManager
@onready var boundary_manager: BoundaryManager = %BoundaryManager

#事件管理
##事件等级
enum GRADE{
	Basic,
	Intermediate,
	Advanced
}

##事件类型
enum EVENTS {
	boundary_change,
	enemies_target_change
	}

@export var current_grade:GRADE
@export var current_events:EVENTS


func _ready() -> void:
	Events.requesr_round_events.connect(random_eyents_and_grade)

##随机触发事件
func random_eyents_and_grade() -> void:
	var random_grade :int = randi_range(0,2)
	var random_events :int = randi_range(0,1)
	current_grade = random_grade
	current_events = random_events
	on_random_events(current_events)


##事件
func on_random_events(current_events:EVENTS) -> void:
	match current_events:
		EVENTS.boundary_change:
			on_boundary_change(current_grade)
		EVENTS.enemies_target_change:
			enemy_manager.changed_all_enemy_target()
			print("全体敌人追玩家")
			Events.round_events_ui.emit("吸引",GRADE.Advanced)


##边界收缩事件
func on_boundary_change(current_grade:GRADE) -> void:
	match current_grade:
		GRADE.Basic:
			boundary_manager.move_boundary(-500,10)
			print("全边界移动：-500")
			Events.round_events_ui.emit("边界收缩",current_grade)
		GRADE.Intermediate:
			boundary_manager.move_boundary(-700,10)
			print("全边界移动：-1000")
			Events.round_events_ui.emit("边界收缩",current_grade)
		GRADE.Advanced:
			boundary_manager.move_boundary(-1000,10)
			print("全边界移动：-1500")
			Events.round_events_ui.emit("边界收缩",current_grade)
