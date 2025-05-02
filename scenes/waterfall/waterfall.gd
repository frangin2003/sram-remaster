extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE BEFORE THE WATERFALL OF THE LOST CAVE"

	var actions = """- If the hero attempts to go through the waterfall:
  {"_speaker":"001", "_text":"You found the lost cavern. It probably needs a new name.", "_action":"CAVERN"}"""

	if Global.has_item("flasksec"):
		actions += """- If the hero refills the flask:
	{"_speaker":"001", "_text":"You have now a flask full of fresh water.", "_action":"REFILL"}"""

	return {
		"compass": {
			"EAST": "tree",
			"SOUTH": "mountain",
		},
		"description": "The hero stands before a majestic waterfall. Mist hangs in the air, and the sound of crashing water fills the surroundings. Behind the shimmering curtain of water, a faint shadow hints at a hidden passage.",
		"actions": actions
	}

func execute_action(action):
	match action:
		"CAVERN":
			Global.set_scene("cavern")
		"REFILL":
			refill_flask()
			load_scene_config()
		_:
			print("Action not recognized in this scene")
