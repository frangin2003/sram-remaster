extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"NORTH": null,
		"EAST": "tree",
		"SOUTH": "mountain",
		"WEST": null
	})
	Global.SCENE_DESCRIPTION = "The hero is in front of the waterfall of the lost cavern"
	Global.ACTIONS = """
- If the hero wants to go through the waterfall: {"_speaker":"001", "_text":"You found the lost cavern. It probably needs a new name.", "_command":"003"}"""
	CommandHandler.CURRENT_HANDLER = self

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			print("Splash!")
			Global.set_scene("cavern")
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
