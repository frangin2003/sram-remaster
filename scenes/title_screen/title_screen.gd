extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			Global.set_scene(Global.SCENE)
