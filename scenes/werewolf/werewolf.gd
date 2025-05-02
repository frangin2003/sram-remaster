extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var scene_suffix = "_dead" if Global.has_state("werewolf dead") else ""
	self.start_loop_and_show_video(get_node("/root/werewolf/Remaster/Control/VideoStreamPlayerWerewolf%s" % scene_suffix))
	get_node("/root/werewolf/Original/Background").texture = load("res://scenes/werewolf/werewolf%s.png" % scene_suffix)
	var description = """The hero stands in a frozen wilderness, surrounded by snow-laden trees under a crisp blue sky.
The snow crunches faintly underfoot as the tension hangs thick in the icy air, with no sound but the distant howl of the wind."""
	var actions = ""
	if not Global.has_state("werewolf dead"):
		description += """In the clearing, a towering werewolf stares back with calm yet menacing golden eyes, its fur bristling slightly in the cold.
The creature's posture is steady, exuding a quiet power that feels both controlled and threatening."""
		actions = """- If the hero says "You have beautiful eyes, you know", it kills the werewolf:
  {"_speaker":"001", "_text":"It killed it.", "_action":"KILLEDWEREWOLF"}"""
	else:
		description += "The now dead werewolf lies on the ground, its body starting to be covered in snow."
		if not Global.has_item("ear") and not Global.has_state("ear given"):
			if Global.has_item("knife"):
				actions = """- If the hero wants to take the ear, he cuts it with the knife and takes it:
  {"_speaker":"001", "_text":"Congratulations, you have a new disgusting trophy", "_action":"EAR"}"""
			else:
				actions = """- If the hero wants to take the ear:
  {"_speaker":"001", "_text":"You can't, you need something sharp to cut it.", "_action":"XXX"}"""

	return {
		"compass": {
			"EAST": "signpost",
			"SOUTH": "vessel",
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"EAR":
			Global.take_item_and_animate("Remaster", "Ear", 1810, 608)
			Global.take_item_and_animate("Original", "Ear", 1613, 662)
		"KILLEDWEREWOLF":
			get_node("/root/werewolf/Original/Background").texture = load("res://scenes/werewolf/werewolf_dead.png")
			self.stop_and_hide_video(get_node("/root/werewolf/Remaster/Control/VideoStreamPlayerWerewolf"))
			if Global.MODE == "Remaster":
				await self.start_show_then_hide_video(get_node("/root/werewolf/Remaster/Control/VideoStreamPlayerWerewolfDying"))
			get_node("/root/werewolf/Remaster/Ear").visible = true
			get_node("/root/werewolf/Original/Ear").visible = true
			self.start_loop_and_show_video(get_node("/root/werewolf/Remaster/Control/VideoStreamPlayerWerewolf_dead"))
			Global.update_scene_state("werewolf dead")
			load_scene_config()
		_:
			print("Action not recognized in this scene")
