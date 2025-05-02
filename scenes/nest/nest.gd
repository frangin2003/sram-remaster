extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE UP THE TREE"

	var actions = """
- If the hero wants to get down the tree: 
  {"_speaker":"001", "_text":"You leap down with surprising grace. Well done!", "_action":"DOWN"}"""
	if not Global.has_item("knife"):
		actions += """
- If the hero looks at the nest: 
  {"_speaker":"001", "_text":"You see a large bird nest with a knife tucked inside.", "_action":"LOOK"} 
- If the hero wants to take the knife: 
  {"_speaker":"001", "_text":"Careful now—don't cut yourself as you take it.", "_action":"KNIFE"}"""

	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": null
		},
		"description": "The hero stands on a sturdy branch, a large bird nest resting precariously in front of him.",
		"actions": actions
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"LOOK":
			get_node("/root/nest/Remaster/Knife").visible = true
			get_node("/root/nest/Original/Knife").visible = true
		"KNIFE":
			Global.take_item_and_animate("Remaster", "Knife", 95, 300)
			Global.take_item_and_animate("Original", "Knife", 235, 284)
		"DOWN":
			print("Down the tree!")
			Global.set_scene("tree")
		_:
			print("Action not recognized in this scene")
