extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": null,
		"east": null,
		"south": null,
		"west": null
	})
	var knife_instructions = ""
	if Global.INVENTORY["knife"]:
		knife_instructions = """
		- If the hero looks at the nest, say it's empty, no commands"""
	else:
		knife_instructions = """
		- If the hero looks at the nest: {"_speaker":"001", "_text":"There is a knife inside.", "_command":"002"}
		- If the hero wants to take the knife: {"_speaker":"001", "_text":"Beware not to cut yourself.", "_command":"003"}"""
	Global.set_system_instructions("The hero is on branch with a large bird nest in front of him. There is a knife in the nest",
	"""%s
	- If the hero wants to get down the tree: {"_speaker":"001", "_text":"Hop!", "_command":"004"}
	""" % knife_instructions)
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Knife")
	# INVENTORY[item_name.to_lower()]

func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			var sprite = get_node("/root/nest/Knife")
			if sprite:
				sprite.visible = true
		"003":
			Global.take_item_and_animate("Knife", 95, 300)
		"004":
			print("Down the tree!")
			Global.set_scene("tree")
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
