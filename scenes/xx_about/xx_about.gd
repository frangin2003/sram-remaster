extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_1:
			Global.load_scene(Global.SCENE)
		elif event.pressed and event.keycode == KEY_2:
			$Remaster/MarginContainer.visible = true
			$Original/Background.visible = false
			$Original/MarginContainer.visible = true
