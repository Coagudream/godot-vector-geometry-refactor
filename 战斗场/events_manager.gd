class_name EventsManager
extends Node

@onready var round_manager: RoundManager = %RoundManager
@onready var enemy_manager: EnemyManager = %EnemyManager
@onready var boundary_manager: BoundaryManager = %BoundaryManager

#事件管理
enum GRADE{
	Basic,
	Intermediate,
	Advanced
}

enum EVENTS {
	boundary_change,
	enemies_target_change
	}

@export var current_grade:GRADE
@export var current_events:EVENTS

##随机化事件
func random_eyents_and_grade() -> void:
	pass

##边界收缩事件
func on_boundary_change(_current_grade:GRADE) -> void:
	match current_grade:
		GRADE.Basic:
			boundary_manager.move_boundary(300,10)
		GRADE.Intermediate:
			boundary_manager.move_boundary(500,10)
		GRADE.Advanced:
			boundary_manager.move_boundary(1000,10)
