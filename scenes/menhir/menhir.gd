extends "res://scenes/BaseScene.gd"

# French text:
# Cinomeh le grand pretre a pris le pouvoir, il a destitue Egres 4 et l'a enferme avec sa famille dans les caves du temple. Tu dois venir les sauver. Va voir Edualc la sorciere, elle te donnera 5 vies si tu  les a meritees... L'Ermite peut t'aider. Va si tu est courageux. Un ami qui te veut du bien...

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": "tree",
			"EAST": "bird",
			"SOUTH": "druids",
			"WEST": "mountain"
		},
		"description": """The hero stands in a windswept valley under a bright, clear sky, where a few clouds drift lazily above.
At the center of the valley, a towering menhir rises, its surface seems engraved with mysterious text.""",
		"actions": """- If the hero is looking at the menhir or the mysterious text:
	{"_speaker":"001", "_text":"You find an engraved text on the menhir", "_action":"LOOK"}"""
	}

func execute_action(action):
	match action:
		"LOOK":
			get_node("/root/menhir/Remaster/MenhirText").visible = true
			await get_tree().create_timer(10.0).timeout
			Global.set_scene("menhir")
		_:
			print("Action not recognized in this scene")
