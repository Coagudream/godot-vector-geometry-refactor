class_name CharacterState
extends Resource

@export_group("生命相关")
@export var max_health : float

#接口
func return_resource_copy() -> Resource:
	return null
