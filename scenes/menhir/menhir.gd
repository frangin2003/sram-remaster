extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = null
	return {
		"compass": {
			"NORTH": "tree",
			"EAST": "bird",
			"SOUTH": "druids",
			"WEST": "mountain"
		},
		"description": """The hero stands in a windswept valley under a bright, clear sky, where a few clouds drift lazily above.
At the center of the valley, a towering menhir rises, its surface engraved with mysterious text: 
“Please save King Cinomeh.“""",
	}
