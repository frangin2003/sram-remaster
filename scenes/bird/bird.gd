extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": "hogg",
			"WEST": "menhir"
		},
		"description": "The hero gazes up at a flock of pigeons gliding effortlessly across a vibrant blue sky, their wings slicing through the air like graceful dancers. Among them, one pigeon stands out, carrying a small, tightly bound message attached to its foot. The sun catches the golden hue of the envelope, making it glimmer as the bird soars higher. The vast landscape below stretches endlessly, dotted with fields and distant clouds. It’s clear this pigeon is on a mission, its path purposeful and unwavering.",
		"actions": """
- If the hero whistles:
{... "_text":""A pigeon lands on your hand."", "_command":"PIGEON"}"""
	}

func execute_command(command):
	print("Command: " + command)
	match command:
		"PIGEON":
			# start the video
			pass
		_:
			print("Command not recognized in this scene")
