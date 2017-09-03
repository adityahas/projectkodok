extends Node

func _ready():
	set_fixed_process(true)
	scene_manager.connect("scene_exit", self, "_on_exit_scene")

func _fixed_process(delta):
	pass

func _on_exit_scene():
	scene_manager.play_exit_scene()

func _on_btn_setting_button_up():
#	scene_manager.change_scene_to(game.SCENE_SETTING)
	scene_manager.append_scene(game.SCENE_SETTING, get_node("."))


func _on_btn_play_button_up():
	scene_manager.change_scene_to(game.SCENE_ACTION_PHASE)


func _on_btn_draft_scene_center_button_up():
	scene_manager.change_scene_to(game.SCENE_DRAFT_CENTER)
