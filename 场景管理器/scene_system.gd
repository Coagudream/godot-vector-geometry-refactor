extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum Scenes {
	SCENE_MAIN,
	SCENE_CESHI,
}

@export var scenes :Array[PackedScene]

var previous_scene : PackedScene
var current_scene : PackedScene

func in_new_scene(scene_index:Scenes):
	animation_player.play("scene_in")
	await animation_player.animation_finished
	
	current_scene = scenes[scene_index]
	
	get_tree().change_scene_to_packed(scenes[scene_index])
	
	animation_player.play("scene_out")


func set_old_scene(scene_index:Scenes):
	current_scene = scenes[scene_index]
