extends Node

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	pass

func _on_btn_setting_button_up():
	scene_manager.change_scene_to(game.SCENE_SETTING)


func _on_btn_play_button_up():
	scene_manager.change_scene_to(game.SCENE_ACTION_PHASE)
