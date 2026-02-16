class_name BuffHandle
extends GridContainer

@export var character_property: PlayerState

var bufflist :Array[BuffDesign]

func to_find_buff(buff_data_id :int) -> BuffDesign:
	for buff in bufflist:
		if buff_data_id == buff.buff_data.id:
			return buff
	return null


# 插入排序函数
func insertion_sort(arr:Array):
	for i in range(1, arr.size()):
		var key = arr[i]
		var j = i - 1
		# 将元素向右移动，直到找到合适的位置插入key
		while j >= 0 and arr[j].buff_data.prioity > key.buff_data.prioity:
			arr[j + 1].buff_data.prioity = arr[j].buff_data.prioity
			j -= 1
		bufflist[j + 1] = key


func buff_tick_and_remove(delta:float) -> void:
	var delet_buff_list : Array[BuffDesign]
	
	for buff in bufflist:
		#tick_time
		if buff.buff_data.on_tick != null:
			if buff.buff_data.tick_time < 0:
				buff.buff_data.on_tick.Apply(buff)
				buff.tick_time = buff.buff_data.tick_time
			else:
				buff.tick_time -= delta
		
		#remove
		if buff.duratio_time <= 0:
			delet_buff_list.append(buff)
		else:
			buff.duratio_time -= delta
	
	for delet_buff in delet_buff_list:
		remove_buff(delet_buff)



#添加Buff
func add_buff(buff_design:BuffDesign) -> void:
	var find_buff :BuffDesign = to_find_buff(buff_design.buff_data.id)
	#buff已经存在
	if find_buff != null :
		if find_buff.cur_stack < find_buff.buff_data.max_stack:
			find_buff.cur_stack += 1
			buff_design.visible = false
			#时间更新方式
			match find_buff.buff_data.buff_time_updata_enum:
				"Add":
					find_buff.duratio_time += find_buff.buff_data.duration
				"Replace":
					find_buff.duratio_time = find_buff.buff_data.duration
				"Keep": 
					pass
			#Buff创建时的回调点
			find_buff.buff_data.on_create.Apply(find_buff)
	#buff不存在
	else:
		buff_design.cur_stack = 1 #这里修改添加时的层数
		buff_design.duratio_time = buff_design.buff_data.duration #这里修改添加时的初始时间
		buff_design.buff_data.on_create.Apply(buff_design)
		bufflist.append(buff_design)
		buff_design.tick_time = buff_design.buff_data.tick_time  # 回调时间控制
		
		insertion_sort(bufflist) #buff排序


#移除Buff
func remove_buff(buff_design:BuffDesign) -> void:
	
	match buff_design.buff_data.buff_remove_stack_updata_enum:
		
		"Clear":
			buff_design.buff_data.on_remove.Apply(buff_design)
			bufflist.erase(buff_design)
			#bufflist.remove_at(bufflist.find(buff_design)) #测试两个方法的时间成本
			buff_design.queue_free()
			
		"Reduce":
			buff_design.cur_stack -= 1
			buff_design.buff_data.on_remove.Apply(buff_design) #Buff移除时的回调点
			if buff_design.cur_stack == 0:
				bufflist.erase(buff_design)
				#bufflist.remove_at(bufflist.find(buff_design))
				buff_design.queue_free()
			else:
				buff_design.duratio_time = buff_design.buff_data.duration


func _process(delta: float) -> void:
	buff_tick_and_remove(delta)

func _ready() -> void:
	for child in get_children():
		child.queue_free()

func _on_child_entered_tree(node: Node) -> void:
	if not node is BuffDesign:
		return
	
	node.target = character_property
	add_buff(node)
