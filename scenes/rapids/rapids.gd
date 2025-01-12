extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"EAST": "mountain",
		},
		"description": """The scene presents a roaring river with treacherous rapids churning violently between rugged cliffs. 
 The water crashes against sharp rocks, sending frothy sprays high into the air. 
 The surrounding cliffs, barren and imposing, amplify the sense of danger, while patches of sparse vegetation cling to the steep slopes, 
 a stark contrast to the turbulent waters below.
 The hero faces a perilous challenge: crossing the river would mean navigating the merciless currents that threaten to pull anything into their chaotic embrace.
 The air is filled with the thunderous roar of the rapids, warning of the imminent danger ahead.
 This is not a place to tread lightly—every step or decision must be calculated to avoid a watery demise.""",
		"actions": """- If the hero tries to swim into the rapids:
  {"_speaker":"001", "_text":"You drown.", "_action":"DEATH"}"""
	}

func execute_action(action):
	match action:
		"DEATH":
			Global.set_scene("xx_death")
		_:
			print("Action not recognized in this scene")
