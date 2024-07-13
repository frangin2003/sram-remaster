extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.SCENE = "mountain"
	Global.COMPASS = {
		"north": "waterfall",
		"east": "menhir",
		"south": null,
		"west": "rapids"
	}
	Global.set_system_instructions("The hero is in a valley on top of a hill, a large moutain is visible in the background and a large rock stands atop of the hill",
	"""
	- If the hero wants to take the bow: {"_speaker":"SPE_001", "_text":"Bow bow bow.", "_command":"003"}
	""")
	CommandHandler.CURRENT_HANDLER = self

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			Global.take_item_and_animate("Bow", 112, 616)
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
