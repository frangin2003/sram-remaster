extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Arrow")

	var description = """The hero stands in a wide valley, perched atop a grassy hill.
In the distance, a towering mountain looms under a clear sky. Nearby, a large rock sits firmly atop the hill"""
	var actions = ""
	if not Global.has_item("bow"):
		description += " with a bow lying next to it."
		actions += """
- If the hero attempts to take the bow:
  {"_speaker":"001", "_text":"Now you need an arrow.", "_action":"BOW"}"""
	else:
		description += "."

	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": null
		},
		"description": description,
		"actions": actions
	}

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
  {"_speaker":"001", "_text":"Be careful not to prick yourself!", "_action":"ARROW"}"""
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"ARROW":
			Global.take_item_and_animate("Remaster", "Arrow", 120, 512, -114)
			Global.take_item_and_animate("Original", "Arrow", 240, 564)
		_:
			print("Action not recognized in this scene")
