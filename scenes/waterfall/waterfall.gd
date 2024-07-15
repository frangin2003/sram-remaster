extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_compass({
		"north": null,
		"east": "tree",
		"south": "mountain",
		"west": null
	})
	Global.set_system_instructions("The hero is in front of the waterfall of the lost cavern")
	CommandHandler.CURRENT_HANDLER = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
