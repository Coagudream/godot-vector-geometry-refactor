extends State
@onready var player: CharacterBody2D = $"../.."

func enter():
	player.state_name = self.name
	pass
	
func update(_delta: float):
	if player.direction_vector.length() == 0 :
		update_state.emit("IDLE")
		
	if Input.is_action_just_pressed("sprint"):
		update_state.emit("SPRINT")
	
func physics_update(_delta: float):
	player.is_move(_delta)
	pass
	
	
func exit():
	pass
	
