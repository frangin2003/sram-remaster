extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	# Connect the signal from HeroTextEdit
	var hero_text_edit = get_node("/root/lutin/Remaster/gui_remaster/HeroTextEdit")
	hero_text_edit.connect("speak_seconds", speak_seconds)
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Shovel")
	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": "tree"
		},
		"description": "The hero is facing a smiling Leprechaun blocking a large river",
		"npcs": """
	## Leprechaun
The Leprechaun is named Fergus Floodgate ("_speaker":"003"), he is the guardian of the river and is very funny, speaking with Irish accent.
- If the hero attacks the Leprechaun: {"_speaker":"001", "_text":"The Leprechaun cuts you in half. You're dead", "_command":"000"}
- If the hero asks the Leprechaun how to cross the river: {"_speaker":"003", "_text":"To cross the river, you need to talk to give me the ermit potion.", "_command":"999"}"""
	}

func speak_seconds(speaker, seconds):
	Global.speak_seconds(speaker, seconds)

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			Global.take_item_and_animate("Remaster", "Potion", 112, 616)
		_:
			print("Command not recognized in this scene")
