extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	if Global.has_state("arrow given"):
		Global.hide_item("Arrow")
	else:
		Global.show_hide_item("Arrow")

	var description = """The hero finds themselves on a small, serene island in the middle of a glistening lake.
The soft glow of the golden sunlight filters through the lush canopy of vines and trees,
casting dancing reflections on the water. The air is still, save for the occasional ripple across the lake, 
and the scene feels like a test of skill, waiting to be revisited or admired.
At the center of the island, a wooden target stands proudly"""
	var actions = """
- If the hero wants to get out of the island: 
  {"_speaker":"001", "_text":"You balance back on the shore with a liana like Tarzan.", "_action":"BACK"}"""
	if not Global.has_item("arrow") or not Global.has_state("arrow given"):
		description += " with an arrow lodged perfectly in its bullseye."
		actions += """
- If the hero attempts to take the arrow:
  {"_speaker":"001", "_text":"Beware not to prick yourself.", "_action":"ARROW"}"""
	else:
		description += "."

	return {
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"ARROW":
			Global.take_item_and_animate("Remaster", "Arrow", 120, 512, -114)
			Global.take_item_and_animate("Original", "Arrow", 240, 564)
			load_scene_config()
		"BACK":
			print("Back to the shore!")
			Global.set_scene("swamps")
		_:
			print("Action not recognized in this scene")
