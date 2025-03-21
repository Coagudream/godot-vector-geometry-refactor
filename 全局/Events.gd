extends Node

#游戏
signal round_start(current_round:int)  ##第一回合回合开始
signal round_end  ##回合结束
signal request_next_round_start  ##请求下一个回合开始


#玩家
signal player_lv_up(player_state:PlayerState)  ##玩家升级信号
signal request_injury_flashing                 ##请求受伤红闪
signal request_low_blood_volume_warning_start  ##请求开始低血量预警
signal request_low_blood_volume_warning_exit   ##请求结束低血量预警
 
#玩家升级卡牌
signal requset_show_card_manager  ##请求展示卡牌组
signal requset_hide_card_manager  ##请求隐藏卡牌组

#游戏边界
signal game_boundary_changed(rect:Rect2)   ##游戏边界改变信号

#核心
signal core_inning_start   ## 指针与核心链接信号
signal core_lv_up(current_lv:int)  ##核心升级信号
signal core_broken  ##核心破碎信号

#摄像机
signal request_camera_sharked(strength:float)##摄像机震动请求信号
