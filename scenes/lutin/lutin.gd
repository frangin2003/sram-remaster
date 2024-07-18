extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the signal from HeroTextEdit
	var hero_text_edit = get_node("gui/HeroTextEdit")
	hero_text_edit.connect("speak_seconds", speak_seconds)
	Global.set_compass({
		"north": null,
		"east": null,
		"south": null,
		"west": "tree"
	})
	Global.SCENE_DESCRIPTION = "The hero is facing a smiling Leprechaun blocking a large river"
	Global.NPCS = """
	## Leprechaun
The Leprechaun is named Fergus Floodgate ("_speaker":"003"), he is the guardian of the river and is very funny, speaking with Irish accent.
- If the hero attacks the Leprechaun: {"_speaker":"001", "_text":"The Leprechaun cuts you in half. You're dead", "_command":"000"}
- If the hero asks the Leprechaun how to cross the river: {"_speaker":"003", "_text":"To cross the river, you need to talk to give me the ermit potion.", "_command":"999"}
	"""
	CommandHandler.CURRENT_HANDLER = self

func speak_seconds(speaker, seconds):
	Global.speak_seconds(speaker, seconds)

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
