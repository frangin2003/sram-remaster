extends "res://scenes/BaseScene.gd"

var time_to_wait = 0.0
var timer_started = 0.0

func _process(_delta):
	var audio_player = get_node("/root/snake/Remaster/AudioStreamPlayerHissing")
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if time_to_wait == 0.0:
		# Initial setup of wait time
		time_to_wait = randf_range(4.0, 8.0)
		timer_started = current_time
	
	if not audio_player.playing and (current_time - timer_started >= time_to_wait):
		audio_player.play()
		# Set up next wait interval
		time_to_wait = randf_range(4.0, 8.0)
		timer_started = current_time

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": "waterfall",
			"EAST": "menhir",
			"SOUTH": null,
			# "WEST": "rapids"
			"WEST": null
		},
		"description": "The hero stands in a wide valley, perched atop a grassy hill. In the distance, a towering mountain looms under a clear sky. Nearby, a large rock sits firmly atop the hill, with a bow lying next to it.",
		"actions": """
- If the hero attempts to take the bow:
  {"_speaker":"001", "_text":"Now you need an arrow.", "_action":"BOW"}"""
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"BOW":
			Global.take_item_and_animate("Remaster", "Bow", 112, 616)
			Global.take_item_and_animate("Original", "Bow", 282, 659)
		_:
			print("Action not recognized in this scene")
