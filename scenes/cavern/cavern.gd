extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var scene_suffix = "_skeleton_buried" if Global.has_state("skeleton buried") else ""
	get_node("/root/cavern/Remaster/Control/Sprite2D").texture = load("res://scenes/cavern/cavern%s.webp" % scene_suffix)
	get_node("/root/cavern/Original/Control/Sprite2D").texture = load("res://scenes/cavern/cavern%s_original_background.png" % scene_suffix)
	Global.show_hide_item("Shovel")


	var description = "The hero stands in the cavern."
	var actions = ""
	if Global.has_state("skeleton buried"):
		description += " In front of him lies the now buried unfortunate past adventurer and a large wooden barrel resting against the damp wall."
	else:
		description += " In front of him lies the skeleton of an unfortunate past adventurer and a large wooden barrel resting against the damp wall."
		actions = """
- If the hero attempts to bury the skeleton:
  {"_speaker":"001", "_text":"As a reward for your act of kindness, here’s a piece of advice: use the stick when facing the slitherer.", "_action":"BURY"}"""

	if not Global.has_item("shovel"):
		description += " Next to it lies a shovel."
		actions += """
- If the hero attempts to take the shovel:
  {"_speaker":"001", "_text":"That can be handy.", "_action":"SHOVEL"}"""

	if not Global.has_item("flask"):
		actions += """
- If the hero looks into the barrel:
  {"_speaker":"001", "_text":"Inside the barrel, you find an empty leather flask. You take it.", "_action":"FLASK"}"""

	return {
		"compass": {
			"NORTH": null,
			"EAST": "cactus",
			"SOUTH": null,
			"WEST": "waterfall"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"SHOVEL":
			Global.take_item_and_animate("Remaster", "Shovel", 59, 575, 0)
			Global.take_item_and_animate("Original", "Shovel", 224, 664, 0)
		"FLASK":
			get_node("/root/cavern/Remaster/Flask").visible = true
			Global.take_item_and_animate("Remaster", "Flask", 97, 688)
			get_node("/root/cavern/Original/Flask").visible = true
		"BURY":
			Global.take_item_and_animate("Remaster", "Shovel", 59, 575, 0)
			Global.take_item_and_animate("Original", "Shovel", 224, 664, 0)
			get_node("/root/cavern/Remaster/Control/Sprite2D").texture = load("res://scenes/cavern/cavern_skeleton_buried.webp")
			get_node("/root/cavern/Original/Control/Sprite2D").texture = load("res://scenes/cavern/cavern_skeleton_buried_original_background.png")
			Global.update_scene_state("skeleton buried")
		_:
			print("Action not recognized in this scene")
