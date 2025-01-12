extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = """The hero finds himself at the Pond of Frogs,
 a tranquil sanctuary surrounded by lush greenery and the calm reflections of nature on its still waters. 
 A lone frog sits atop a weathered log in the foreground, seemingly watching over the pond. 
 Scattered across the water, clusters of lily pads float gently. A large trunk of a tree lies on the ground."""

	var action = ""

	if not Global.has_item("lilipad"):
		description += """ Among them, one particularly beautiful lily pad rests in the middle of the pond, shimmering under the sunlight. 
 Its placement feels significant, yet it's tantalizingly out of direct reach."""
		action = """- If the hero uses the trunk to swim to the lilipad:
  {"_speaker":"001", "_text":"Congratulations for your new trophy!", "_action":"LILIPAD"}"""

	if Global.has_item("flasksec"):
		action += """- If the hero refills the flask:
	{"_speaker":"001", "_text":"You have now a flask full of fresh water.", "_action":"REFILL"}"""

	return {
		"compass": {
			"NORTH": "hogg",
			"EAST": "quicksands",
			"WEST": "swamps"
		},
		"description": description,
		"actions": action
	}

func execute_action(action):
	match action:
		"LILIPAD":
			Global.take_item_and_animate("Remaster", "Lilipad", 1815, 325, NAN, 0.181, 0.181)
			Global.take_item_and_animate("Original", "Lilipad", 1626, 357)
			load_scene_config()
		"REFILL":
			refill_flask()
			load_scene_config()
		_:
			print("Action not recognized in this scene")
