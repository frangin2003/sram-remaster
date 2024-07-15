extends Node

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_scene(scene_id):
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	Global.set_scene(scene_id)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
