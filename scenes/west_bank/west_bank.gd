extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"WEST": "centaur",
		},
		"description": """The hero stands on a pristine tropical beach, where golden sand stretches out beneath swaying palm trees. 
 Gentle waves lap at the shore, their turquoise waters shimmering under the bright sunlight. 
 In the distance, a lush green island rises majestically from the sea, its slopes covered in dense foliage and rocky outcrops. 
 The sky is a brilliant blue, dotted with fluffy white clouds that drift lazily, framing the island like a serene painting. 
 The faint cry of seagulls echoes in the air, and a soft breeze carries the salty scent of the ocean, 
 beckoning the hero toward the mysterious island.""",
		"actions": """
- If the hero is swimming to the island:
  {"_speaker":"001", "_text":"You looked like a fish.", "_action":"SWIM"}"""
	}

func execute_action(action):
	match action:
		"SWIM":
			Global.set_scene("turtle")
		_:
			print("Action not recognized in this scene")
