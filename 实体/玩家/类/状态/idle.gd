extends State

@onready var player: CharacterBody2D = $"../.."

# TODO 可以添加微小值判定
#var should_move :bool :
	#get : return abs(player.velocity.length()-0.1) < 0 

func enter():
	player.state_name = self.name
	player.velocity = Vector2.ZERO
	
func update(_delta: float):
	if player.direction_vector.length() != 0 :
		update_state.emit("MOVE")
	
	if Input.is_action_just_pressed("sprint"):
		update_state.emit("SPRINT")
	
	
func physics_update(_delta: float):
	
	pass
	
	
func exit():
	pass
