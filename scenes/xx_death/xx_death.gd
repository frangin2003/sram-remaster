extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			Global.reset_inventory()
			Global.set_scene("menhir")
