extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Bow")
	return {
		"compass": {
			"NORTH": "waterfall",
			"EAST": "menhir",
			"SOUTH": null,
			# "WEST": "rapids"
			"WEST": null
		},
		"description": "The hero is in a valley on top of a hill, a large moutain is visible in the background and a large rock stands atop of the hill with a bow near it.",
		"actions": """
- If the hero wants to take the bow: {... "_text":"Now you need an arrow.", "_command":"002"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			Global.take_item_and_animate("Remaster", "Bow", 112, 616)
			Global.take_item_and_animate("Original", "Bow", 282, 659)
		_:
			print("Command not recognized in this scene")
