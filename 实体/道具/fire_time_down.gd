extends ItemS

var amount :float = -0.06

func apply_effect(_nodes:Array[Node]):
	var attack_interval := AttackDuationEffect.new()
	attack_interval.amount = amount
	attack_interval.execute(_nodes)
