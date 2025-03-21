class_name BuffModuleBM
extends BuffModule

@export var property :Property

func Apply (buff_info:BuffDesign) :
	var chatacter :CharacterProperty = buff_info.target
	
	if chatacter :
		match property.algorithm:
			"Add":
				chatacter.max_health += property.max_health
				chatacter.max_speed += property.speed
				#chatacter.accatk += property.accatk
			"Multiply":
				chatacter.max_health *= (1.0 + property.max_health/100.0)
				chatacter.max_speed *= (1.0 + property.speed/100.0)
				#chatacter.accatk *= (1.0 + property.accatk/100.0)
