extends Node

var SCREENSHOT: PackedByteArray
var SCREENSHOT_URL = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func resetScreenshot():
	SCREENSHOT = PackedByteArray()
	SCREENSHOT_URL = null

func _ready():
	resetScreenshot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
