extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self

	var description = """The hero stands in a wide valley, perched atop a grassy hill.
In the distance, a towering mountain looms under a clear sky. Nearby, a large rock sits firmly atop the hill"""
	var actions = ""
	if not Global.has_item("bow") and not Global.has_state("bow given"):
		Global.show_item("Bow")
		description += " with a bow lying next to it."
		actions += """
- If the hero attempts to take the bow:
  {"_speaker":"001", "_text":"Now you need an arrow.", "_action":"BOW"}"""
	else:
		Global.hide_item("Bow")
		description += "."

	return {
		"compass": {
			"NORTH": "waterfall",
			"EAST": "menhir",
			"WEST": "rapids"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"BOW":
			Global.take_item_and_animate("Remaster", "Bow", 112, 616)
			Global.take_item_and_animate("Original", "Bow", 282, 659)
		_:
			print("Action not recognized in this scene")
