#extends Node2D

#var canvas_item :RID= RenderingServer.canvas_item_create() # RID

#func _ready() -> void:

	#RenderingServer.canvas_item_set_parent(canvas_item, get_canvas_item())

	#RenderingServer.canvas_item_add_rect(canvas_item, Rect2(0,0,100,200), Color.AQUA, true)

#func _exit_tree() -> void:

	#RenderingServer.free_rid(canvas_item)
#-------------------------------------
extends Node2D

var canvas_item :RID= RenderingServer.canvas_item_create() # RID
var offset = 0

func _ready() -> void:
	RenderingServer.canvas_item_set_parent(canvas_item, get_canvas_item())

func _process(delta):
	offset += 50*delta # 每秒增加50
	RenderingServer.canvas_item_clear(canvas_item) # 如果去掉这一行 我们会连续的绘制很多矩形
	RenderingServer.canvas_item_add_rect(canvas_item, Rect2(offset,offset,100,200), Color.AQUA, true)

func _exit_tree() -> void:
	RenderingServer.free_rid(canvas_item)
