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
	tooltip = "增加%s点速度" %amount


func apply_effect(nodes:Array[Node]):
	
	var speed_up := MaxSpeedEffect.new()
	speed_up.amount = amount

	speed_up.execute(nodes)
