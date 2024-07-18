extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": null,
		"east": "desertdoor",
		"south": null,
		"west": "waterfall"
	})

	Global.SCENE_DESCRIPTION = "The hero is in the cavern, in front of him the resting skeleton of a poor past adventurer, and a large barrel."
	var scene_suffix = "_skeleton_buried" if "skeleton buried" in Global.get_scene_state().split(", ") else ""
	get_node("/root/%s/Control/Sprite2D" % Global.SCENE).texture = load("res://scenes/cavern/cavern%s.webp" % scene_suffix)
	Global.ACTIONS = """
- If the hero wants to take the shovel: {"_speaker":"001", "_text":"That can be handy.", "_command":"002"}
- If the hero wants to burry the skeleton: {"_speaker":"001", "_text":"As a reward for your act of kindness, here is an advice. Use the stick when facing the slitherer.", "_command":"004"}
- If the hero looks into the barrel: {"_speaker":"001", "_text":"There is an empty leather flask, you take it.", "_command":"003"}"""
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Shovel")

func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			Global.take_item_and_animate("Shovel", 59, 575, 0)
		"003":
			get_node("/root/%s/Flask" % Global.SCENE).visible = true
			Global.take_item_and_animate("Flask", 97, 688)
		"004":
			Global.take_item_and_animate("Shovel", 59, 575, 0)
			get_node("/root/%s/Control/Sprite2D" % Global.SCENE).texture = load("res://scenes/cavern/cavern_skeleton_buried.webp")
			Global.update_scene_state("skeleton buried")
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
