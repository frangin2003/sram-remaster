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
		"description": "The hero stands in a wide valley, perched atop a grassy hill. In the distance, a towering mountain looms under a clear sky. Nearby, a large rock sits firmly atop the hill, with a bow lying next to it.",
		"actions": """
- If the hero attempts to take the bow:
  {"_speaker":"001", "_text":"Now you need an arrow.", "_command":"BOW"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"EAR":
			Global.take_item_and_animate("Remaster", "Ear", 1810, 608)
			Global.take_item_and_animate("Original", "Ear", 1613, 662)
		_:
			print("Command not recognized in this scene")
