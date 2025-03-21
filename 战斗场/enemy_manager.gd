class_name EnemyManager
extends Node2D

var bounder_rect :Rect2

func _ready() -> void:
	Events.round_end.connect(remove_all_enemy)
	Events.round_start.connect(add_enemies)
	Events.game_boundary_changed.connect(func(rect:Rect2): bounder_rect = rect)


##添加一群敌人
func add_enemies(current_round:int) -> void:
	for i in range(10):
		add_enemy(current_round)

##添加一个敌人
func add_enemy(_current_round:int) -> void:
	var new_enemy_ordinary_factory:MonsterOrdinaryFactory = MonsterOrdinaryFactory.new()
	var new_enemy =  new_enemy_ordinary_factory.create_enemy("min_genmetry")
	random_ememies_position(new_enemy)

##随机敌人位置并且添加敌人
func random_ememies_position(enemy:Enemy) -> void:
	var rect2_range:Rect2 = bounder_rect
	enemy.global_position = Vector2(randf_range(rect2_range.position.x,rect2_range.end.x),randf_range(rect2_range.position.y,rect2_range.end.y))
	add_child(enemy)

##移除全部敌人子节点
func remove_all_enemy() -> void:
	for child in get_children():
		if child is Enemy:
			child.queue_free()

##敌人全组修改追踪目标（事件）
func changed_all_enemy_target() -> void:
	for child in get_children():
		if child is Enemy:
			child.enemy_property.taregt_count = EnemyState.Target.to_player
