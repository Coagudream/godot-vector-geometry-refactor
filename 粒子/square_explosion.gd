extends GPUParticles2D

func _ready() -> void:
	one_shot = true
	emitting = true
	die()

func die():
	await get_tree().create_timer(lifetime).timeout
	queue_free()
