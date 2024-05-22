extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_initialize_compass")

func _initialize_compass():
	get_node("North").visible = Global.COMPASS["north"]
	get_node("East").visible = Global.COMPASS["east"]
	get_node("South").visible = Global.COMPASS["south"]
	get_node("West").visible = Global.COMPASS["west"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
