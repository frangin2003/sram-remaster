extends "res://scenes/BaseScene.gd"

var hero_has_drunk_water = false
var actions_before_dying = 8

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = """YOU ARE DEEP IN THE DESERT,
PARCHED"""

	Global.BLOCK_MOVEMENTS = true
	var actions = ""
	if hero_has_drunk_water:
		Global.BLOCK_MOVEMENTS = false

	if Global.has_item("flaskeau"):
		actions = """- If the hero wants to drink water to be able to move, do the following action 'DRINK' (also never mention 'flaskeau' in your text response:
  {"_speaker":"001", "_text":"You drink the water, and now your thirst is quenched.", "_action":"DRINK"}"""

	return {
		"compass": {
			"NORTH": "vessel",
			"SOUTH": "desert_1",
		},
		"description": """The hero stumbles through an endless expanse of golden dunes, the blazing sun beating mercilessly overhead.
 The rippling patterns of the sand stretch far into the horizon, untouched and desolate. 
 Nearby, a skeletal carcass lies half-buried in the sand, its bleached bones a grim reminder of the desert's unforgiving nature. 
 The air is still, save for the faint whisper of shifting grains carried by the scorching wind.
 The hero's mouth is parched, their steps heavy and faltering. 
 Each breath feels like fire, and the heat presses down relentlessly. 
 Without water, they know they cannot continue further—a desperate thirst claws at their resolve as the harsh desert seems to stretch 
 endlessly before them.""",
		"actions": actions
	}

func execute_action(action):
	match action:
		"DRINK":
			hero_has_drunk_water = true
			Global.remove_from_inventory("flaskeau")
			Global.add_to_inventory("flasksec")
			load_scene_config()
		_:
			if not hero_has_drunk_water:
				actions_before_dying -= 1

			if actions_before_dying == 0:
				set_text("You die of thirst. You are dead. Like dead dead")
				Global.set_scene("xx_death")

			print("Action not recognized in this scene")
