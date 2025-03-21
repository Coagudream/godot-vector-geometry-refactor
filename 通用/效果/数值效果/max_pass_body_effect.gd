class_name MaxPassBodyEffect
extends Effect

var amount: int = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
		
		if target is Player :
			
			target.take_max_pass_body(amount)
			#SFXPlayer.play(sound)
