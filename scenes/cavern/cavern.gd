extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	var scene_suffix = "_skeleton_buried" if "skeleton buried" in Global.get_scene_state().split(", ") else ""
	get_node("/root/cavern/Remaster/Control/Sprite2D").texture = load("res://scenes/cavern/cavern%s.webp" % scene_suffix)
	get_node("/root/cavern/Original/Control/Sprite2D").texture = load("res://scenes/cavern/cavern%s_original_background.png" % scene_suffix)
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Shovel")
	return {
		"compass": {
			"NORTH": null,
			"EAST": "cactus",
			"SOUTH": null,
			"WEST": "waterfall"
		},
		"description": "The hero is in the cavern, in front of him the resting skeleton of a poor past adventurer, and a large barrel.",
		"actions": """
- If the hero wants to take the shovel: {"_speaker":"001", "_text":"That can be handy.", "_command":"002"}
- If the hero wants to burry the skeleton: {"_speaker":"001", "_text":"As a reward for your act of kindness, here is an advice. Use the stick when facing the slitherer.", "_command":"004"}
- If the hero looks into the barrel: {"_speaker":"001", "_text":"There is an empty leather flask, you take it.", "_command":"003"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			Global.take_item_and_animate("Remaster", "Shovel", 59, 575, 0)
			Global.take_item_and_animate("Original", "Shovel", 224, 664, 0)
		"003":
			get_node("/root/cavern/Remaster/Flask").visible = true
			Global.take_item_and_animate("Remaster", "Flask", 97, 688)
			get_node("/root/cavern/Original/Flask").visible = true
		"004":
			Global.take_item_and_animate("Remaster", "Shovel", 59, 575, 0)
			Global.take_item_and_animate("Original", "Shovel", 224, 664, 0)
			get_node("/root/cavern/Remaster/Control/Sprite2D").texture = load("res://scenes/cavern/cavern_skeleton_buried.webp")
			get_node("/root/cavern/Original/Control/Sprite2D").texture = load("res://scenes/cavern/cavern_skeleton_buried_original_background.png")
			Global.update_scene_state("skeleton buried")
		_:
			print("Command not recognized in this scene")
