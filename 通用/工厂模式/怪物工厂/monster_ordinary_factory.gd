class_name MonsterOrdinaryFactory
extends MonsterFactory


func create_enemy(name:String) -> Enemy:
	match name:
		"min_genmetry":
			return preload("res://实体/敌人/enemy.tscn").instantiate() as Enemy
		_:
			return null
