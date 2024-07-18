extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": null,
		"east": "lutin",
		"south": "menhir",
		"west": "waterfall"
	})
	Global.SCENE_DESCRIPTION = "The hero is in a dense forest, birds are chirping, in front of him stands a large tree that can be climbed"
	Global.ACTIONS = """
- If the hero wants to climb the tree: {"_speaker":"001", "_text":"You climb like a squirrel!", "_command":"003"}"""
	CommandHandler.CURRENT_HANDLER = self

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			print("Climbs!")
			Global.set_scene("nest")
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
