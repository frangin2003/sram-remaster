extends "res://scenes/BaseScene.gd"

func init_scene():
	Global.show_hide_item("Shovel")

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var scene_suffix = "_skeleton_buried" if Global.has_state("skeleton buried") else ""
	get_node("/root/cavern/Remaster/Background").texture = load("res://scenes/cavern/cavern%s.webp" % scene_suffix)
	get_node("/root/cavern/Original/Background").texture = load("res://scenes/cavern/cavern%s_original_background.png" % scene_suffix)

	var description = "The hero stands in the cavern."
	var actions = ""
	if Global.has_state("skeleton buried"):
		description += " In front of him lies the now buried unfortunate past adventurer and a large wooden barrel resting against the damp wall."
	else:
		description += " In front of him lies the skeleton of an unfortunate past adventurer and a large wooden barrel resting against the damp wall."
		actions = """- If the hero wants to bury the skeleton:
  {"_speaker":"001", "_text":"", "_action":"BURY"}"""

	if not Global.has_item("shovel"):
		description += " Next to it lies a shovel."
		actions += """- If the hero is taking the shovel:
  {"_speaker":"001", "_text":"That can be handy.", "_action":"SHOVEL"}"""

	if not Global.has_item("flasksec") and not Global.has_item("flaskeau"):
		actions += """- If the hero looks into the barrel:
  {"_speaker":"001", "_text":"Inside the barrel, you find an empty leather flask. You take it.", "_action":"FLASK"}"""

	return {
		"compass": {
			"EAST": "waterfall",
			"WEST": "cactus"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"SHOVEL":
			Global.take_item_and_animate("Remaster", "Shovel", 59, 575, 0)
			Global.take_item_and_animate("Original", "Shovel", 224, 664, 0)
			load_scene_config()
		"FLASK":
			get_node("/root/cavern/Remaster/Flasksec").visible = true
			Global.take_item_and_animate("Remaster", "Flasksec", 97, 688)
			get_node("/root/cavern/Original/Flasksec").visible = true
			load_scene_config()
		"BURY":
			if not Global.has_item("shovel"):
				Global.take_item_and_animate("Remaster", "Shovel", 59, 575, 0)
				Global.take_item_and_animate("Original", "Shovel", 224, 664, 0)

			if Global.MODE == "Remaster":
				await self.start_show_then_hide_video(get_node("/root/cavern/Remaster/Control/VideoStreamPlayer"))

			Global.update_scene_state("skeleton buried")
			set_text("As a reward for your act of kindness, here’s a piece of advice: use the stick when facing the slitherer.")
			load_scene_config()
		_:
			print("Action not recognized in this scene")
