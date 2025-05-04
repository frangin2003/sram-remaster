extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE ON A PLATEAU"

	return {
		"compass": {
			"EAST": "cliff",
			"SOUTH": "hogg",
			"WEST": "menhir"
		},
		"description": """The hero gazes up at a flock of pigeons gliding effortlessly across a vibrant blue sky,
 their wings slicing through the air like graceful dancers. Among them, one pigeon stands out, carrying a small,
 tightly bound message attached to its foot. The sun catches the golden hue of the envelope,
 making it glimmer as the bird soars higher. The vast landscape below stretches endlessly,
 dotted with fields and distant clouds. It’s clear this pigeon is on a mission,
 its path purposeful and unwavering.""",
		"actions": """
- If the hero whistles:
{... "_text":"", "_action":"PIGEON"}"""
	}

func execute_action(action):
	match action:
		"PIGEON":
			set_text("""A pigeon lands on your hand. Attached to its foot is a small, tightly bound message that says:
I AM STRANDED WITH MY FAMILY IN THE OLD PRISON, COME HELP US! KING EGRES IV""")
			if Global.MODE == "Remaster":
				self.stop_and_hide_video(get_node("/root/bird/Remaster/Control/VideoStreamPlayer"))
				await self.start_show_then_hide_video(get_node("/root/bird/Remaster/Control/VideoStreamPlayerBirdLanded"))
				self.start_loop_and_show_video(get_node("/root/bird/Remaster/Control/VideoStreamPlayer"))
		_:
			print("Action not recognized in this scene")
