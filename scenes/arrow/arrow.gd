extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Arrow")
	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": null
		},
		"description": "The hero finds themselves in a serene riverside clearing bathed in the golden glow of a setting sun. Towering trees with cascading vines frame the tranquil water, their leaves whispering softly in the breeze. In the foreground, a wooden archery target stands near the edge of the clearing, its vibrant red, blue, and yellow rings catching the sunlight. The gentle ripples of the river reflect the warm hues of the sky, and the scene exudes a sense of peace, yet hints at a challenge waiting to be undertaken.",
		"actions": """
- If the hero attempts to take the arrow:
  {"_speaker":"001", "_text":"Be careful not to prick yourself!", "_command":"ARROW"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"ARROW":
			Global.take_item_and_animate("Remaster", "Arrow", 120, 512, -114)
			Global.take_item_and_animate("Original", "Arrow", 240, 564)
		_:
			print("Command not recognized in this scene")
