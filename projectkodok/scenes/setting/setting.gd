extends Node

func _ready():
	scene_manager.connect("scene_exit", self, "_on_exit_scene")
	pass

func _on_exit_scene():
	scene_manager.play_exit_scene(get_node("."))

func _on_btn_back_button_up():
	scene_manager.remove_scene(get_node("."))
