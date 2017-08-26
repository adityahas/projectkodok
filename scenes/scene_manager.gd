extends CanvasLayer

signal scene_enter
signal scene_exit
signal scene_changed
var is_changing = false
var scene_current = game.SCENE_SPLASH
var scene_prev
var scene_next
var scene_stack = []

func _ready():
	set_fixed_process(true)

func change_scene_back():
	if is_changing:
		return
	if scene_stack.size() > 1:
		scene_stack.pop_back()
		_change_scene(scene_stack[scene_stack.size() - 1])

func change_scene_to(scene_path):
	if is_changing:
		return
	scene_stack.append(scene_path)
	_change_scene(scene_path)

func _change_scene(scene_path):
	if scene_path == null:
		return
	if is_changing:
		return

	is_changing = true

	get_tree().get_root().set_disable_input(true)

	emit_signal("scene_exit")

	#add fade out to black
	get_node("anim").play("fade_in")
	yield(get_node("anim"), "finished")

	# Load new scene
	var packed_scene = ResourceLoader.load(scene_path)
	var instanced_scene = packed_scene.instance()

	# Immediately free the current scene, there is no risk here.
	get_tree().get_current_scene().free()

	# Add it to the scene tree, as direct child of root
	get_tree().get_root().add_child(instanced_scene)

	# Set it as the current scene, only after it has been added to the tree
	get_tree().set_current_scene(instanced_scene)
	emit_signal("scene_changed")

	get_tree().get_root().set_disable_input(false)

	if get_tree().get_current_scene() != null:
		#add fade in to scene
		get_node("anim").play("fade_out")
		yield(get_node("anim"), "finished")

	is_changing = false
	scene_next = scene_path
	scene_prev = scene_current
	scene_current = scene_next


func _fixed_process(delta):
	pass

func _exit_tree():
	pass

func get_scene_current():
	return scene_current

func get_scene_next():
	return scene_next

func get_scene_prev():
	return scene_prev