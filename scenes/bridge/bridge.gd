extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": "cliff",
			"WEST": "hogg"
		},
		"description": """The hero approaches a tranquil shoreline bathed in the vibrant hues of a setting sun, painting the sky with shades of pink,
 orange, and purple. A weathered wooden bridge extends gracefully across the calm waters, leading to a small, lush island crowned with trees.
 The reflection of the sun and vivid sky dances on the water’s surface, creating a mesmerizing tapestry of colors.
 The gentle ripples and scattered rocks in the shallow water add a touch of serenity, while the path across the bridge beckons with quiet mystery,
 promising discovery beyond the horizon.""",
		"actions": """
- If the hero attempts to cross the bridge:
  {"_speaker":"001", "_text":"You are now on snake island.", "_action":"BRIDGE"}"""
	}

func execute_action(action):
	match action:
		"BRIDGE":
			Global.set_scene("snake")
		_:
			print("Action not recognized in this scene")
