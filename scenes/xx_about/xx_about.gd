extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	return {}

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_1:
			Global.set_scene("menhir")
		elif event.pressed and event.keycode == KEY_2:
			$Remaster/MarginContainer.visible = true
			$Original/Background.visible = false
			$Original/MarginContainer.visible = true
