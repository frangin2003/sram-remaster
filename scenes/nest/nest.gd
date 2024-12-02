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
		"description": "The hero stands on a sturdy branch, a large bird nest resting precariously in front of him. Within the nest, glinting in the light, lies a sharp knife.",
		"actions": """
- If the hero looks at the nest: 
  {"_speaker":"001", "_text":"You see a large bird nest with a knife tucked inside.", "_command":"LOOK"} 
- If the hero wants to take the knife: 
  {"_speaker":"001", "_text":"Careful now—don't cut yourself as you take it.", "_command":"KNIFE"} 
- If the hero wants to get down the tree: 
  {"_speaker":"001", "_text":"You leap down with surprising grace. Well done!", "_command":"DOWN"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"LOOK":
			var sprite = get_node("/root/nest/Remaster/Knife")
			if sprite:
				sprite.visible = true
			sprite = get_node("/root/nest/Original/Knife")
			if sprite:
				sprite.visible = true
		"KNIFE":
			Global.take_item_and_animate("Remaster", "Knife", 95, 300)
			Global.take_item_and_animate("Original", "Knife", 235, 284)
		"DOWN":
			print("Down the tree!")
			Global.set_scene("tree")
		_:
			print("Command not recognized in this scene")
