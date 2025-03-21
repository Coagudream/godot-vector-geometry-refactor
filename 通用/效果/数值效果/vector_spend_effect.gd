class_name VectorSpendEffect
extends Effect

var amount: float = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
		
		if target is Player :
			
			target.take_vector_spend(amount)
			#SFXPlayer.play(sound)
