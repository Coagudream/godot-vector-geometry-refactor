class_name  Fluctuate
extends ColorRect

@onready var color_rect: ColorRect = $"."

const RADIUS_CORRECT :int = 10

var ring_color:Color:
	set(v):
		ring_color = v
		up_data()
	
var amplitude:float:
	set(v):
		amplitude = v
		up_data()
		
var ring_speed:float:
	set(v):
		ring_speed = v
		up_data()

func _set_radius(radius:float) -> void:
	var new_scale = radius/(100 - RADIUS_CORRECT*2)
	var new_size = Vector2(new_scale,new_scale)
	scale = new_size

func _set_ring_color(r_color:Color) ->void:
	ring_color = r_color

func _set_amplitude(amplitude_power:float) ->void:
	amplitude = amplitude_power

func _set_ring_speed(ring_speeds:float) ->void:
	ring_speed = ring_speeds


func up_data() -> void:
	material.set_shader_parameter("ring_color", ring_color)
	material.set_shader_parameter("amplitude", amplitude)
	material.set_shader_parameter("ring_speed", ring_speed)
