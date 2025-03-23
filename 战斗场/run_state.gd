class_name RunState
extends HBoxContainer

@onready var gem_amount: Label = %GemAmount

@export var run_state:RunStateS

var run_state_ :RunStateS

func _ready() -> void:
	run_state_ = run_state.return_resource_copy() as RunStateS
	run_state_.run_updata_cahnged.connect(run_updata)
	run_updata()

func run_updata() -> void:
	gem_amount.text = "%s" %run_state_.gem_amount


func take_gem_amount(amount:int) -> void:
	run_state_.gem_amount += amount
