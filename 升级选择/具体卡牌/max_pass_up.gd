extends PlayerUp

func set_var() -> void:
	match type:
		Type.common:
			amount = 1
		Type.rare:
			amount = 2
		Type.fine:
			amount = 3
		Type.epic:
			amount = 4
		Type.legendary:
			amount = 5
	tooltip = "增加%s个可穿过敌人" %amount


func apply_effect(nodes:Array[Node]):
	
	var max_pass_body_up := MaxPassBodyEffect.new()
	max_pass_body_up.amount = amount
	max_pass_body_up.execute(nodes)
