class_name CollDamageEffect
extends Effect
var amount: float = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
		
		if target is Enemy or Player:
			
			target.take_coll_damage(amount)
			#SFXPlayer.play(sound)
