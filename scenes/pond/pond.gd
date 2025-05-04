extends "res://scenes/BaseScene.gd"

func init_scene():
	ActionHandler.CURRENT_HANDLER = self
	if Global.has_item("Lilypad") or Global.has_state("lilypad given"):
		Global.hide_item("Lilypad")
	else:
		Global.show_item("Lilypad")


func _get_scene_config() -> Dictionary:
	get_node("Original/gui_original/SceneDescription").text = """YOU ARE BESIDE A POND.
THERE ARE WATER-LILIES"""

	var description = """The hero stands near the Pond of Frogs,
 a tranquil sanctuary surrounded by lush greenery and the calm reflections of nature on its still waters.
 The pond stretches ahead to the south, but pathways lead NORTH, EAST, and WEST through the surrounding greenery.
 A lone frog sits atop a weathered log in the foreground, seemingly watching over the pond. 
 Scattered across the water, clusters of lily pads float gently.
 A large trunk lies near the edge of the pond, clearly usable as a makeshift raft, allowing to reach lily pads."""
	
	var action = ""

	if not Global.has_item("lilypad"):
		if Global.has_item("knife"):
			description += """ Among them, one particularly beautiful lily pad rests in the middle of the pond, shimmering under the sunlight. 
	Its placement feels significant, yet it's tantalizingly out of direct reach."""
			action = """- If the hero uses the trunk to swim to the lily pad:
  {"_speaker":"001", "_text":"Congratulations for your new trophy!", "_action":"LILYPAD"}
- If the hero swims to the lily pad on the trunk:
  {"_speaker":"001", "_text":"Congratulations for your new trophy!", "_action":"LILYPAD"}"""
		else:
			description += """ You need a knife to get lily pads."""

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
		"LILYPAD":
			Global.take_item_and_animate("Remaster", "Lilypad", 1815, 325, NAN, 0.181, 0.181)
			Global.take_item_and_animate("Original", "Lilypad", 1626, 357)
			load_scene_config()
		"REFILL":
			refill_flask()
			load_scene_config()
		_:
			print("Action not recognized in this scene")
