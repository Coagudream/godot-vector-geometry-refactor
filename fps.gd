extends Label

func _process(_delta: float) -> void:
	text = str(Performance.get_monitor(Performance.TIME_FPS)) # 将 FPS 打印到控制台
