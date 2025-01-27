extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": "werewolf",
			"EAST": "cactus",
			"SOUTH": "desert_2",
		},
		"description": """The hero stands amidst an endless expanse of scorching desert, battered by fierce winds that whip up a haze of sand,
 making every step a struggle. In the distance, an astonishing sight emerges: a massive wooden vessel stranded in the shifting dunes.
 The ship, weathered by time and stripped of its sails, leans precariously as if frozen mid-journey through an ocean of sand.
 Its towering masts creak under the desert's relentless gusts, and the shadow it casts stretches long across the rippling dunes.
 This surreal scene is both eerie and mesmerizing—a relic of the past, lost to the unforgiving sands.
 The hero feels the weight of mystery, knowing this ship may hold secrets, treasures, or perils.""",
		"actions": """
- If the hero wants to enter the ship:
{"_speaker":"001", "_text":"You enter the ship, how mysterious... boooh", "_action":"ENTER"}"""
	}

func execute_action(action):
	match action:
		"ENTER", "ENTERSHIP", "ENTEREDSHIP", "INSIDESHIP":
			Global.set_scene("chest")
		_:
			print("Action not recognized in this scene")
