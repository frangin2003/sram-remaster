extends Node

var pixelate_layer: CanvasLayer

func _ready():
	print("Original/Remater switch on")
	set_process_input(true)
	pixelate_layer = load("res://scenes/xx_pixelate/xx_pixelate.tscn").instantiate()
	add_child(pixelate_layer)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F1:
		handle_f1_press()

func pixelate():
	# Make sure to return the awaitable value
	return await pixelate_layer.pixelate()

func unpixelate():
	return await pixelate_layer.unpixelate()

func update_mode_visibility():
	await get_tree().process_frame  # Let visibility changes take effect
	var current_scene_name = get_tree().get_current_scene().name
	var remaster_node = get_node("/root/%s/Remaster" % current_scene_name)
	var original_node = get_node("/root/%s/Original" % current_scene_name)

	if remaster_node:
		remaster_node.visible = Global.MODE == "Remaster"
	if original_node:
		original_node.visible = Global.MODE == "Original"

func handle_f1_press():
	print("F1 key pressed")
	
	# First capture current state with shader
	await get_tree().process_frame
	
	# Start pixelation
	await pixelate()
	
	# Make changes under the pixelation
	var new_mode = "Remaster" if Global.MODE == "Original" else "Original"
	Global.update_mode(new_mode)
	print("Mode switched to: %s" % Global.MODE)
	
	update_mode_visibility()
	
	await get_tree().process_frame  # Let visibility changes take effect

	await unpixelate()
