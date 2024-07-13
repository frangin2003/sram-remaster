extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			#NavigationManager.go_to_scene('menhir')
			get_tree().change_scene_to_file("res://scenes/menhir/menhir.tscn")
