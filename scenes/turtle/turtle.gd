extends "res://scenes/BaseScene.gd"

var eggs_unearthed = false

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = """The hero finds himself on Turtle Island, a serene paradise where golden sands stretch under a radiant blue sky.
 The gentle waves lap softly against the shore, their rhythmic melody harmonizing with the distant calls of seabirds.
 A majestic sea turtle rests nearby, its patterned shell gleaming under the warm sunlight, as if standing guard over the island's secrets.
 Lush green hills rise in the background, blending seamlessly into the horizon, while fluffy clouds drift lazily above.
 The island feels alive with a quiet magic, inviting the hero to explore its tranquil beauty and hidden mysteries."""
	var actions = ""

	if not Global.has_item("eggs") or not Global.has_state("eggs given"):
		if eggs_unearthed:
			description += " Some eggs are unearthed and ready to be picked up."
			actions += """- If the hero takes the eggs:
	{"_speaker":"001", "_text":"Do not make an omelet out of them.", "_action":"EGGS"}"""
		else:
			actions += """- If the hero shovels the sand:
	{"_speaker":"001", "_text":"You have unearthed some yummy eggs.", "_action":"SHOVEL"}"""

	return {
		"compass": {
			"WEST": "west_bank" 
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"SHOVEL":
			self.eggs_unearthed = true
			Global.show_item("Eggs")
			load_scene_config()
		"EGGS":
			Global.take_item_and_animate("Remaster", "Eggs", 1828, 247)
			Global.take_item_and_animate("Original", "Eggs", 1619, 206)
			load_scene_config()
		_:
			print("Action not recognized in this scene")
