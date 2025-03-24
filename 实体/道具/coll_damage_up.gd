extends ItemS

var amount :float = 10

func apply_effect(_nodes:Array[Node]):
	var coll_damage := CollDamageEffect.new()
	coll_damage.amount = amount
	coll_damage.execute(_nodes)
