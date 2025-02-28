extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_initialize_compass")

func _initialize_compass():
	print(Global.COMPASS)
	get_node("North").visible = Global.COMPASS["NORTH"] != null
	get_node("East").visible = Global.COMPASS["EAST"] != null
	get_node("South").visible = Global.COMPASS["SOUTH"] != null
	get_node("West").visible = Global.COMPASS["WEST"] != null
