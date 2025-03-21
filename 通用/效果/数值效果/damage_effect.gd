class_name DamageEffect
extends Effect

var amount: float = 0

func execute(targets:Array[Node]) -> void:
	if targets.is_empty():
		return
	for target in targets:
		
		if not target: #安全检查
			continue
		
		if target is Enemy or Player:
			
			#这个take_damage函数在玩家中使用了封装
			target.take_damage(amount)
			#SFXPlayer.play(sound)
