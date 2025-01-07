extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = """The scene shows the Ermit, a large, jovial man with a bushy white beard and a warm smile, standing confidently in front of his rustic wooden house. 
 His simple clothing, complete with suspenders, adds to his humble and approachable demeanor. 
 The house behind him is weathered but sturdy, with planks leaning against it and a bucket nearby, giving the impression of a peaceful, self-sufficient life in the countryside. 
 The surrounding open landscape adds a serene and welcoming atmosphere."""
	var actions = ""

	if not Global.has_item("Flute"):
		description += " A flute is tucked into his front pocket, hinting at a musical side to his character."
		actions = """
- If the hero attempts to take the flute:
  {"_speaker":"001", "_text":"I'll give it to you if you solve this riddle: What walks on four legs in the morning, two legs at noon, and three legs in the evening?", "_action":"RIDDLE"}
- If the hero correctly answers the riddle (e.g., "man" or similar):
  {"_speaker":"001", "_text":"The flute is yours now, play it in the centaur forest.", "_action":"FLUTE"}"""
	else:
		get_node("/root/hermit/Remaster/ErmitFlute").visible = false
		get_node("/root/hermit/Original/Flute").visible = false

	return {
		"compass": {
			"WEST": "signpost"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"FLUTE":
			get_node("/root/hermit/Remaster/ErmitFlute").visible = false
			get_node("/root/hermit/Remaster/Flute").visible = true
			Global.take_item_and_animate("Remaster", "Flute", 128, 387)
			Global.take_item_and_animate("Original", "Flute", 287, 395)
		_:
			print("Action not recognized in this scene")
