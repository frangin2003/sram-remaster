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
		"description": "The hero is in a dense forest, birds are chirping, in front of him stands a large tree that can be climbed",
		"actions": """
- If the hero wants to climb the tree: {"_speaker":"001", "_text":"You climb like a squirrel!", "_command":"003"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			print("Climbs!")
			Global.set_scene("nest")
		_:
			print("Command not recognized in this scene")
