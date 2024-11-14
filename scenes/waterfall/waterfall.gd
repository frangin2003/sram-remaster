extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": null,
			"EAST": "tree",
			"SOUTH": "mountain",
			"WEST": null
		},
		"description": "The hero is in front of the waterfall of the lost cavern",
		"actions": """
- If the hero wants to go through the waterfall: {"_speaker":"001", "_text":"You found the lost cavern. It probably needs a new name.", "_command":"003"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			print("Splash!")
			Global.set_scene("cavern")
		_:
			print("Command not recognized in this scene")
