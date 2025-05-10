extends "res://scenes/BaseScene.gd"

var actions_before_dying = 8

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = """The hero is ensnared in the clutches of treacherous quicksand, surrounded by the haunting shadows of a murky, dense jungle. 
 The air is thick with humidity, and the dim light of dusk barely penetrates the canopy above. 
 Every frantic movement causes him to sink deeper, the viscous mire tugging relentlessly at his limbs. 
 A thick liana dangles tantalizingly close from a gnarled tree above, its sturdy form offering the only chance of escape. 
 The hero's fingers stretch desperately toward it, his survival hanging by a thread as the suffocating sands threaten to claim him. 
 The atmosphere is tense, the sound of rustling leaves and distant animal cries amplifying the urgency of the moment. 
 Will he seize the liana in time, or will the jungle claim yet another victim?"""
	return {
		"description": description,
		"actions": """- If the hero grabs a liana:
  {"_speaker":"001", "_text":"", "_action":"LIANA"}"""
	}

func execute_action(action):
	match action:
		"LIANA", "GRABBEDLIANA", "USELIANA":
			if Global.MODE == "Remaster":
				await self.start_show_then_hide_video(get_node("/root/quicksands/Remaster/Control2/VideoStreamPlayerLiane"))

			Global.set_scene("pond")
		_:
			actions_before_dying -= 1

			if actions_before_dying == 0:
				Global.set_scene("xx_death")

			print("Action not recognized in this scene")
