extends PlayerUp

func set_var() -> void:
	match type:
		Type.common:
			amount = 10
		Type.rare:
			amount = 20
		Type.fine:
			amount = 30
		Type.epic:
			amount = 40
		Type.legendary:
			amount = 50
	tooltip = "增加%s点伤害" %amount


func apply_effect(nodes:Array[Node]):
	
	var damage_up := DamageEffect.new()
	damage_up.amount = amount
	damage_up.execute(nodes)
