class_name ExpEffect
extends Effect

var amount: float = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
			
		if target is Player or CoreS:
			
			target.take_exp(amount)
			#SFXPlayer.play(sound)
