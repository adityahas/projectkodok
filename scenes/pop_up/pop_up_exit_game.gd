extends Control

func _ready():
	pass

func _on_btn_yes_button_up():
	get_tree().quit()

func _on_btn_no_button_up():
	game.show_exit_confirmation = false
	queue_free()
