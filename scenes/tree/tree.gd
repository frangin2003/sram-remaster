extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": null,
			"EAST": "lutin",
			"SOUTH": "menhir",
			"WEST": "waterfall"
		},
		"description": "The hero finds himself in a dense forest, where the air is alive with the chirping of birds. Towering before him stands a massive tree, its sturdy branches inviting him to climb.",
		"actions": """
If the hero wants to climb the tree:
{"_speaker":"001", "_text":"Up you go! You scramble up the tree like a nimble squirrel.", "_command":"CLIMB"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"CLIMB":
			print("Climbs!")
			Global.set_scene("nest")
		_:
			print("Command not recognized in this scene")
