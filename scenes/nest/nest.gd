extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": null
		},
		"description": "The hero is on branch with a large bird nest in front of him. There is a knife in the nest",
		"actions": """
- If the hero looks at the nest: {... "_text":"There is a knife inside.", "_command":"002"}
- If the hero wants to take the knife: {... "_text":"Beware not to cut yourself.", "_command":"003"}
- If the hero wants to get down the tree: {... "_text":"Hop!", "_command":"004"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			var sprite = get_node("/root/nest/Remaster/Knife")
			if sprite:
				sprite.visible = true
			sprite = get_node("/root/nest/Original/Knife")
			if sprite:
				sprite.visible = true
		"003":
			Global.take_item_and_animate("Remaster", "Knife", 95, 300)
			Global.take_item_and_animate("Original", "Knife", 235.257, 283.888)
		"004":
			print("Down the tree!")
			Global.set_scene("tree")
		_:
			print("Command not recognized in this scene")
