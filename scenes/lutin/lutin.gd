extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.SCENE = "lutin"
	Global.COMPASS = {
		"north": null,
		"east": null,
		"south": null,
		"west": "tree"
	}
	Global.set_system_instructions("The hero is facing a Leprechaun, guarding the river",
	"""
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
