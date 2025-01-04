extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	return {
		"compass": {
			"SOUTH": "bridge",
			"WEST": "bird"
		},
		"description": """The hero stands at the edge of a breathtaking canyon, 
 its towering cliffs carved by time into jagged walls that stretch endlessly into the horizon. 
 Below, a roaring river snakes through the canyon floor, its waters frothing and churning as they crash against boulders scattered along its path. 
 The sunlight filters through the mist rising from the river, casting a golden glow over the rugged terrain. 
 Sparse vegetation clings stubbornly to the rocky cliffs, adding touches of green to the earthy tones of the landscape. 
 The air is filled with the distant thunder of rushing water, and the scene is both majestic and humbling, a reminder of nature's untamed power."""
	}
