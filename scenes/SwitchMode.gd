extends Node

var MODE = "REMASTER"

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_TAB:
		handle_tab_press()

func handle_tab_press():
	print("Tab key pressed")
	MODE = "REMASTER" if MODE == "ORIGINAL" else "ORIGINAL"
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), MODE == "ORIGINAL")
	var current_scene_name = get_tree().current_scene.name
	var remaster_node = get_node("/root/%s/Remaster" % current_scene_name)
	if remaster_node:
		remaster_node.visible = SwitchMode.MODE == "REMASTER"
	var original_node = get_node("/root/%s/Original" % current_scene_name)
	if original_node:
		original_node.visible = SwitchMode.MODE == "ORIGINAL"
