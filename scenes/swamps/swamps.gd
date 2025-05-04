extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE IN THE SWAMPS"

	return {
		"compass": {
			"NORTH": "druids",
			"EAST": "pond",
			"WEST": "east_bank"
		},
		"description": """This mystical swamp is bathed in the golden glow of a setting sun, 
 with an ancient tree towering on a mysterious island in the distance. Its sprawling roots and hanging vines exude an aura of timeless majesty. 
 The murky waters of the swamp reflect the vibrant greenery, but the surface teems with unseen dangers—crocodiles lurk, 
 making it impossible to swim to the island. A sturdy liana waves gently in front of you, as if offering a chance to swing closer. 
 Logs and lush vegetation frame the scene, while the misty backdrop hints at secrets hidden deep within the swamp. 
 The island beckons, yet remains tantalizingly out of reach.""",
		"actions": """- If the hero wants to get to the island with the liana: 
  {"_speaker":"001", "_text":"You balance on the island shore with a liana like Tarzan.", "_action":"LIANA"}
- If the hero uses the liana: 
  {"_speaker":"001", "_text":"You balance on the island shore with a liana like Tarzan.", "_action":"LIANA"}"""
	}

func execute_action(action):
	match action:
		"LIANA", "GRABBEDLIANA", "USELIANA", "SWING":
			Global.set_scene("arrow")
		_:
			print("Action not recognized in this scene")
