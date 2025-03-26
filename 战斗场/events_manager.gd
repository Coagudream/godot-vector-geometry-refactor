class_name EventsManager
extends Node

@onready var round_manager: RoundManager = %RoundManager
@onready var enemy_manager: EnemyManager = %EnemyManager
@onready var boundary_manager: BoundaryManager = %BoundaryManager

const AWAIT_EVENTS:int = 3
const MAX_EVENT_INTERVAL:int = 4

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

var array_event:Array[int]

@export var current_grade:GRADE
@export var current_events:EVENTS

var _not_occur_event:int = 0

func _ready() -> void:
	Events.round_start.connect(request_round_event)
	Events.request_round_events.connect(random_events_and_grade)
	for event in EVENTS.size():
		print(event)
		array_event.append(event)

##请求事件系统(保证随机性)
func request_round_event(current_round:int) -> void:
	await get_tree().create_timer(AWAIT_EVENTS).timeout
	if current_round == 1:
		return
	if current_round == 2:
		random_events_and_grade()
		print("当前回合数%s" %current_round)
	if 1 == randi_range(0,2) :
		random_events_and_grade()
		return
	_not_occur_event += 1
	if _not_occur_event == MAX_EVENT_INTERVAL:
		random_events_and_grade()


##事件权重
func random_power() -> int:
	var random :float = randf() 
	if random >= 0.9:
		return 2
	elif random >= 0.5 :
		return 1
	else :
		return 0


##随机触发事件
func random_events_and_grade() -> void:
	var random_grade :int = random_power()
	var random_events :int = randi_range(0,1)
	current_grade = random_grade
	current_events = shuffle_and_remove_event()
	on_random_events(current_events)
	_not_occur_event = 0

##基于数组保证不会触发连续相同事件
func shuffle_and_remove_event() -> int:
	if array_event.is_empty():
		for event in EVENTS.size():
			array_event.append(event)
	array_event.shuffle()
	return array_event.pop_front()


##事件
func on_random_events(current_events:EVENTS) -> void:
	match current_events:
		EVENTS.boundary_change:
			on_boundary_change(current_grade)
		EVENTS.enemies_target_change:
			enemies_to_target_change()


##敌人追玩家事件
func enemies_to_target_change() -> void:
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
			print("全边界移动：-700")
			Events.round_events_ui.emit("边界收缩",current_grade)
		GRADE.Advanced:
			boundary_manager.move_boundary(-1000,10)
			print("全边界移动：-1000")
			Events.round_events_ui.emit("边界收缩",current_grade)
