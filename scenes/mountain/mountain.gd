extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"NORTH": "waterfall",
		"EAST": "menhir",
		"SOUTH": null,
		# "WEST": "rapids"
		"WEST": null
	})
	Global.SCENE_DESCRIPTION = "The hero is in a valley on top of a hill, a large moutain is visible in the background and a large rock stands atop of the hill with a bow near it."
	Global.ACTIONS = """
- If the hero wants to take the bow: {... "_text":"Now you need an arrow.", "_command":"002"}"""
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Bow")

func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			Global.take_item_and_animate("Bow", 112, 616)
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
