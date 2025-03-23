class_name RunStateS
extends Resource

signal run_updata_cahnged

@export var gem_amount :int = 50:
	set(v):
		gem_amount = v
		run_updata_cahnged.emit()

func return_resource_copy() -> Resource:
	var copy_resource : Resource = self.duplicate()
	return copy_resource
