extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"description": """The hero finds himself in a dimly lit, grimy cell where King Egres IV and his two sons sit slumped on a cold, 
 straw-covered floor. The stone walls are cracked and damp, etched with the signs of long-forgotten sorrow. 
 The once-proud king now looks worn and frail, his eyes heavy with exhaustion. 
 His sons mirror his state, with tangled hair and haggard faces, barely able to lift their heads. 
 All three are too weak to speak, their silence heavy with the weight of their suffering, 
 but their presence still carries the lingering shadow of lost nobility. 
 The air smells of mildew and despair, but the resolve to free them pulses within the hero.""",
		"actions": """- If the hero give the hearts or the force to the king:
  {"_speaker":"001", "_text":"", "_action":"FORCE"}"""
	}

func execute_action(action):
	match action:
		"FORCE":
			Global.set_scene("king")
		_:
			print("Action not recognized in this scene")
