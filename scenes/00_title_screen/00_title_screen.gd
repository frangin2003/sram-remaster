extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			#NavigationManager.go_to_scene('01_menhir')
			get_tree().change_scene_to_file("res://scenes/01_menhir/01_menhir.tscn")
