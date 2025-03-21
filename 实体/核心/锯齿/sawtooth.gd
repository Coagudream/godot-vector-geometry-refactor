extends Core

func apply_core(player_array:Array[Node]) -> void:
	
	for player in player_array:
		if not player is Player:
			return
		
		#这个get_overlapping_bodies()函数只检测area
		
		for area in player.pointer.contact_area:
			
			if not area:
				return
			
			if area is Hitbox:
				area.take_damage(-0.5)
				
