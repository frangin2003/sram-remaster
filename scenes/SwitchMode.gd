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
	get_node("/root/%s/Remaster" % current_scene_name).visible = SwitchMode.MODE == "REMASTER"
	get_node("/root/%s/Original" % current_scene_name).visible = SwitchMode.MODE == "ORIGINAL"
