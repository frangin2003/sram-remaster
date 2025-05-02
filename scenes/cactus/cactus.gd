extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE AT THE EDGE OF THE DESERT, VULTURE COUNTRY"

	return {
		"compass": {
			"NORTH": "signpost",
			"EAST": "cavern",
			"WEST": "vessel"
		},
		"description": """The hero finds themselves in a vast, sun-drenched desert,
 where towering saguaro cacti rise from the golden dunes like silent sentinels.
 A vulture perches ominously atop one of the tallest cacti, scanning the barren landscape as smaller birds circle high in the sky.
Shadows stretch long across the rippled sand, broken by scattered rocks, tufts of dry brush, and clusters of smaller cacti.
The air shimmers with heat, and the endless dunes and distant hills hint at both isolation and a challenge ahead."""
	}
