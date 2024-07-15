extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": null,
		"east": null,
		"south": null,
		"west": "tree"
	})
	Global.set_system_instructions("The hero is facing a smiling Leprechaun blocking a large river",
	null,
	"""
	## Leprechaun
The Leprechaun is named Fergus Floodgate, he is the guardian of the river and is very funny, speaking with Irish accent.
- If the hero attacks the Leprechaun: {"_speaker":"001", "_text":"The Leprechaun cuts you in half. You're dead", "_command":"000"}
- If the hero asks the Leprechaun how to cross the river: {"_speaker":"001", "_text":"To cross the river, you need to talk to give me the ermit potion.", "_command":"999"}
	""")
	CommandHandler.CURRENT_HANDLER = self

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			Global.take_item_and_animate("Potion", 112, 616)
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
