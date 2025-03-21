class_name AccSpeedEffect
extends Effect

var amount: float = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
		
		if target is Enemy or Player:
			
			target.take_accspeed(amount)
			#SFXPlayer.play(sound)
