extends Node2D

func _ready():
	SwitchMode.update_mode_visibility()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode != KEY_F1:
			Global.load_scene("xx_about")
