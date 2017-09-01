extends "res://scenes/game_vars.gd"

signal show_exit_confirmation
var show_exit_confirmation

func _ready():
	connect("show_exit_confirmation", self, "_show_exit_confirmation")
	set_fixed_process(true)
	init_app()
	pass

func init_app():
	# for android to avoid quite on back key pressed
	get_tree().set_auto_accept_quit(false)
	pass

func _fixed_process(delta):
	update_input()
	pass

func _notification(what):
	handle_exit_notification(what)

func update_input():
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

	# for Mac OSX
	if Input.is_key_pressed(KEY_META):
		if Input.is_key_pressed(KEY_Q):
			get_tree().quit()
		if Input.is_key_pressed(KEY_W):
			scene_manager.change_scene_back()


func handle_exit_notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if scene_manager.scene_current == game.SCENE_MAIN_MENU:
			emit_signal("show_exit_confirmation")
		else:
			scene_manager.change_scene_back()

func _show_exit_confirmation():
	if !show_exit_confirmation:
		var scene = load(game.SCENE_POP_UP_EXIT_GAME)
		var node = scene.instance()
		get_tree().get_current_scene().add_child(node)
		show_exit_confirmation = true