extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var actions = """- If the hero tries to swim into the rapids:
  {"_speaker":"001", "_text":"You drown.", "_action":"DEATH"}"""

	if Global.has_item("flasksec"):
		actions += """- If the hero refills the flask:
	{"_speaker":"001", "_text":"You have now a flask full of fresh water.", "_action":"REFILL"}"""

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
 This is not a place to tread lightly—every step or decision must be calculated to avoid a watery demise. Going back EAST is fine though.""",
		"actions": actions
	}

func execute_action(action):
	match action:
		"REFILL":
			refill_flask()
			load_scene_config()
		"DEATH":
			Global.set_scene("xx_death")
		_:
			print("Action not recognized in this scene")
