extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode != KEY_TAB and event.keycode != KEY_ESCAPE:
			Global.set_scene(Global.SCENE)
