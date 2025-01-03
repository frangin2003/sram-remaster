extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": null,
			"EAST": "tree",
			"SOUTH": "mountain",
			"WEST": null
		},
		"description": "The hero stands before a majestic waterfall. Mist hangs in the air, and the sound of crashing water fills the surroundings. Behind the shimmering curtain of water, a faint shadow hints at a hidden passage.",
		"actions": """
- If the hero attempts to go through the waterfall:
  {"_speaker":"001", "_text":"You found the lost cavern. It probably needs a new name.", "_action":"CAVERN"}"""
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"CAVERN":
			print("Splash!")
			Global.set_scene("cavern")
		_:
			print("Action not recognized in this scene")
