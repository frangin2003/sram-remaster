extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.SCENE = "tree"
	Global.COMPASS = {
		"north": null,
		"east": "waterfall",
		"south": "menhir",
		"west": "leprechaun"
	}
	Global.set_system_instructions("The hero is in a dense forest, birds are chirping, in front of him stands a large tree that can be climbed",
	"""
	- If the hero wants to climb the tree: {"_speaker":"SPE_001", "_text":"You climb like a squirrel!", "_command":"003"}
	""")
	CommandHandler.CURRENT_HANDLER = self

func execute_command(command):
	print("Command: " + command)
	match command:
		"003":
			print("Climbs!")
			# NavigationManager.go_to_scene('nest')
			get_tree().change_scene_to_file("res://scenes/nest/nest.tscn")
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
