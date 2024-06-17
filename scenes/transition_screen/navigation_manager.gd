extends Node

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_scene(scene_id):
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/" + scene_id + "/" + scene_id + ".tscn")

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
