class_name BuffData
extends Resource

@export_group("Buff基本信息")
@export var id :int     ##ID
@export var name:String  ##名称
@export_multiline var description:String ##描述
@export var need_icon:bool ##是否显示纹理
@export var icon: Texture2D  ##纹理
@export var max_stack :int   ##最大叠加上限
@export var prioity :int  ##优先级
@export var tags :Array [String]  ##标签

@export_group("时间信息")
@export var is_forever :bool   ##是否永久有效
@export var duration   :float  ##持续时间
@export var tick_time  :float  ##间隔每秒时间


@export_group("Buff叠加时计算时间")
@export_enum('Add','Replace','keep') var buff_time_updata_enum: String ##Add:时间累计  Replace:时间替换刷新  keep:持续减少


@export_group("Buff减层时计算时间")
@export_enum('Clear','Reduce') var buff_remove_stack_updata_enum: String ##Clear:Buff层数消失时时间完全消失   Reduce:Buff层数-1且时间刷新





@export_group("Buff回调点")
@export_subgroup("基础回调点")
@export var on_create :BuffModule ##创建Buff时
@export var on_remove :BuffModule ##移除Buff时
@export var on_tick   :BuffModule ##间隔每秒时间触发Buff时

@export_subgroup("伤害回调点")  
@export var on_hit :BuffModule   ##打出伤害时
@export var on_be_hurt :BuffModule  ##受伤时
@export var on_kill :BuffModule     ##杀其他角色时
@export var on_be_kill :BuffModule  ##被杀时
