extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = null
	return {
		"compass": {  # Compass configuration (optional)
			"NORTH": "tree",
			"EAST": "bird",
			"SOUTH": "druids",
			"WEST": "mountain"
		},
		"description": "The hero is in a windy valley, clear sky, at the center a large menhir with engraved text: 'Please save the King Cinomeh'",
	}
