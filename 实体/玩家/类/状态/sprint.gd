extends State

@onready var player: CharacterBody2D = $"../.."
@onready var sprint_timer: Timer = $"../../Timer/SprintTimer"

func enter():
	player.state_name = self.name
	sprint_timer.start()
	player.is_sprint()
	pass
	
func update(_delta: float):
	if sprint_timer.time_left <= 0 :
		update_state.emit("IDLE")
	
func physics_update(_delta: float):
	pass
	
	
func exit():
	pass
	
