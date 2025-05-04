extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	get_node("Original/gui_original/SceneDescription").text = """YOU ARE IN THE DESERT.
THE SUN BEATS DOWN"""

	return {
		"compass": {
			"NORTH": "desert_2",
			"SOUTH": "centaur",
		},
		"description": """The hero finds themselves amidst a vast desert of rolling golden dunes, 
 each crest shimmering under the intense light of the blazing sun. The undulating sands stretch endlessly in every direction, 
 creating a hypnotic pattern of light and shadow. The sky above is a rich, deep blue, 
 with a few wisps of clouds scattered like strokes of a painter's brush. 
 The heat is palpable, and the air shimmers with waves of mirage, making the distant dunes appear to dance. 
 This is a place of both beauty and challenge, a test of endurance in an endless sea of sand.""",
	}

