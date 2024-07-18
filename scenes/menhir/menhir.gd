extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": "tree",
		"east": "bird",
		"south": "druids",
		"west": "mountain"
	})
	Global.SCENE_DESCRIPTION = "The hero is in a windy valley, clear sky, at the center a large menhir with engraved text: 'Please save the King Cinomeh'"
	CommandHandler.CURRENT_HANDLER = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
