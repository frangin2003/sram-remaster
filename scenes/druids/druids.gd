extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Cane")
	var description = """The hero steps into the heart of an ancient forest, a sacred place where druids once gathered.
 The air is thick with the scent of moss and earth, and beams of light filter through the dense canopy above, casting an ethereal glow. 
 At the center of the clearing lies a perfectly drawn pentagram on the ground, glowing faintly with an otherworldly energy. 
 Surrounding it are moss-covered stone pillars, each carved with intricate druidic symbols. 
 One of the stones leans slightly, its polished surface glinting softly in the light. 
 The whispers of the forest seem to hum in harmony with the energy emanating from the pentagram, 
 as if the place itself is alive with forgotten power.
 The remains of an old stone wall and scattered branches encircle the area, adding to the sense of an ancient ritual ground."""
	var actions = ""
	if not Global.has_item("Cane"):
		description += """ The stone is supporting a wooden cane that appears to have been left behind."""
		actions += """
- If the hero is taking the cane:
  {"_speaker":"001", "_text":"A third leg can be handy!", "_action":"CANE"}"""

	return {
		"compass": {
			"NORTH": "menhir",
			"EAST": "hogg",
			"SOUTH": "swamps"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"CANE", "CANETAKEN":
			Global.take_item_and_animate("Remaster", "Cane", 63, 396)
			Global.take_item_and_animate("Original", "Cane", 217, 378)
		_:
			print("Action not recognized in this scene")
