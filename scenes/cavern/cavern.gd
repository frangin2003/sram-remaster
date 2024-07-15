extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": null,
		"east": "desertdoor",
		"south": null,
		"west": "waterfall"
	})
	set_system_instructions()
	CommandHandler.CURRENT_HANDLER = self
	Global.show_hide_item("Shovel")

func set_system_instructions():
		var scene_description = ""
		var skeleton_instructions = ""
		if Global.INVENTORY["burried_skeleton"]:
			scene_description = "The hero is in the cavern, in front of him the now burried skeleton of the poor adventurer."
			get_node("/root/%s/Control/Sprite2D" % Global.SCENE).texture = load("res://scenes/cavern/burried_skeleton.webp")
			skeleton_instructions = ""
		else:
			if Global.INVENTORY["shovel"]:
				scene_description = "The hero is in the cavern, in front of him the resting skeleton of a poor past adventurer."
				get_node("/root/%s/Control/Sprite2D" % Global.SCENE).texture = load("res://scenes/cavern/cavern.webp")
				skeleton_instructions = """
				- If the hero wants to burry the skeleton: {"_speaker":"001", "_text":"As a reward for your act of kindness, here is an advice. Use the stick when facing the slitherer.", "_command":"004"}"""
			else:
				scene_description = "The hero is in the cavern, in front of him a wooden barrel and the resting skeleton of a poor past adventurer. There is a shovel next to it."
				skeleton_instructions = """
				- If the hero wants to burry the skeleton, he can't as he needs to pick up the shovel first."""

		var shovel_instructions = ""
		if Global.INVENTORY["shovel"]:
			shovel_instructions = ""
		else:
			shovel_instructions = """
			- If the hero wants to take the shovel: {"_speaker":"001", "_text":"That can be handy.", "_command":"002"}"""

		var flask_instructions = ""
		if Global.INVENTORY["flask"]:
			scene_description += " Also there is the now empty barrel."
			flask_instructions = ""
		else:
			scene_description += " Also there is a barrel."
			flask_instructions = """
			- If the hero looks into the barrel: {"_speaker":"001", "_text":"There is an empty leather flask, you take it.", "_command":"003"}"""

		Global.set_system_instructions(scene_description,
		"""%s
		%s
		%s
		""" % [shovel_instructions, flask_instructions, skeleton_instructions])


func execute_command(command):
	print("Command: " + command)
	match command:
		"002":
			Global.take_item_and_animate("Shovel", 59, 575, 0)
			set_system_instructions()
		"003":
			get_node("/root/%s/Flask" % Global.SCENE).visible = true
			Global.take_item_and_animate("Flask", 97, 688)
			set_system_instructions()
		"004":
			Global.update_inventory("burried_skeleton", true)
			get_node("/root/%s/Control/Sprite2D" % Global.SCENE).texture = load("res://scenes/cavern/burried_skeleton.webp")
			set_system_instructions()
		_:
			print("Command not recognized in this scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
