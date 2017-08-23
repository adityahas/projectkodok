extends CanvasLayer

signal scene_changed
signal scene_enter
signal scene_exit
var is_changing = false

var scene_current = game.SCENE_SPLASH
var scene_prev
var scene_next

func _ready():
	connect("scene_changed", self, "_on_scene_changed")
	pass

func _on_scene_changed():
	pass

func change_scene(scene_path):
	if scene_path == null: return
	if is_changing: return

	get_tree().get_root().set_disable_input(true)
	emit_signal("scene_exit")

	scene_next = scene_path
	is_changing = true

	#add fade out to black
	var packed_scene_fade = ResourceLoader.load(game.SCENE_FADE).instance()
	get_tree().get_root().add_child(packed_scene_fade)
	packed_scene_fade.get_node("anim").play("fade_out")
	yield(packed_scene_fade.get_node("anim"), "finished")

	# Load new scene
	var packed_scene = ResourceLoader.load(scene_next)
	var instanced_scene = packed_scene.instance()

	#add fade in to scene
	instanced_scene.add_child(packed_scene_fade)
	packed_scene_fade.get_node("anim").play("fade_in")

	# Immediately free the current scene, there is no risk here.
	get_tree().get_current_scene().free()

	# Add it to the scene tree, as direct child of root
	get_tree().get_root().add_child(instanced_scene)

	# Set it as the current scene, only after it has been added to the tree
	get_tree().set_current_scene(instanced_scene)
	emit_signal("scene_changed")

	yield(packed_scene_fade.get_node("anim"), "finished")
	packed_scene_fade.queue_free()

	scene_prev = scene_current
	scene_current = scene_next
	is_changing = false
	get_tree().get_root().set_disable_input(false)

func get_scene_current():
	return scene_current

func get_scene_next():
	return scene_next

func get_scene_prev():
	return scene_prev