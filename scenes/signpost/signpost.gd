extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE AT LONELY HEARTS CORNER"

	var description = """The scene showcases a serene crossroads amidst a picturesque landscape.
 The place is known as the crossroads of the lonelies.
 A wooden signpost stands at the center, its weathered planks pointing in different directions, inviting travelers to choose their path. 
 To the right, a towering tree provides a sense of grandeur and shade, its branches spreading wide over the dirt path.
 In the background, majestic snow-capped mountains rise against the clear blue sky, their peaks glistening in the sunlight. 
 Sparse shrubs and dry grass cover the foreground, blending into the natural surroundings, while the open expanse exudes a sense of freedom and adventure.
 The air feels crisp and calm, hinting at the promise of discovery ahead."""

	var actions = ""
	
	if Global.has_state("signpost read"):
		get_node("/root/signpost/Remaster/Knine").visible = true
		get_node("/root/signpost/Original/Knine").visible = true
		get_node("/root/signpost/Remaster/Herrmit").visible = true
		get_node("/root/signpost/Original/Herrmit").visible = true
	else:
		actions = """- If the hero looks at the signpost:
  {"_speaker":"001", "_text":"Here you go.", "_action":"SIGNPOST"}"""

	return {
		"compass": {
			"EAST": "hermit",
			"SOUTH": "cactus",
			"WEST": "werewolf"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"SIGNPOST":
			Global.update_scene_state("signpost read")
			load_scene_config()
		_:
			print("Action not recognized in this scene")
