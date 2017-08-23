extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_btn_setting_button_up():
	scene_manager.change_scene(game.SCENE_SETTING)
	pass # replace with function body
