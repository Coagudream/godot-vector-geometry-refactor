class_name MaxSpeedEffect
extends Effect

var amount: float = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
		
		if target is Enemy or Player or CoreS:
			
			target.take_max_speed(amount)
			#SFXPlayer.play(sound)
