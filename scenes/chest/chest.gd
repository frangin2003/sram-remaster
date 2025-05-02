extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = "YOU ARE IN THE HOLD"

	var description = """The hero finds themselves in the dimly lit hold of a wooden ship, 
 where beams of sunlight stream through cracks in the deck above, illuminating the space with a warm glow.
 The creaking of the ship's structure echoes softly, and the air carries the faint scent of saltwater and aged wood. 
 Surrounding the center of the room are benches, barrels, and support beams, 
 all worn from years of use but sturdy. A staircase leads up to the deck, 
 hinting at the bustling life above. The scene feels both tranquil and full of untold secrets."""
	var actions = """
- If the hero wants to exit the vessel: 
  {"_speaker":"001", "_text":"You exit the vessel, back to the burning sun.", "_action":"EXIT"}"""

	if Global.has_state("chest opened"):
		self.stop_and_hide_video(get_node("/root/chest/Remaster/Control/VideoStreamPlayerChestClosed"))
		if Global.has_item("money"):
			self.start_loop_and_show_video(get_node("/root/chest/Remaster/Control/VideoStreamPlayerChestEmpty"))
			get_node("/root/chest/Original/Background").texture = load("res://scenes/chest/coffre_vide.png")
			description += """At the center sits a large, opened and now empty treasure chest."""
		else:
			self.start_loop_and_show_video(get_node("/root/chest/Remaster/Control/VideoStreamPlayerChestOpened"))
			get_node("/root/chest/Original/Background").texture = load("res://scenes/chest/coffre2.png")
			Global.show_item("Money")
			description += """At the center sits a large, opened and full of golden coins treasure chest."""
			actions += """
- If the hero is taking the coins:
	{"_speaker":"001", "_text":"You take the all the coins. Somehow they fit in your pocket.", "_action":"TAKECOINS"}"""
	else:	
		description += """At the center sits a large, closed, reinforced treasure chest, 
 its metal bands gleaming faintly in the light."""

	if Global.has_item("shovel"):
		actions += """
- If the hero attempts to open the treasure chest, he can as he has the shovel:
	{"_speaker":"001", "_text":"", "_action":"OPENCHEST"}"""
	else:
		actions += """
- If the hero attempts to open the treasure chest:
	{"_speaker":"001", "_text":"You need a strong tool like a shovel to open the treasure chest.", "_action":"NOPE"}"""

	return {
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"OPENCHEST":
			if Global.MODE == "Remaster":
				self.stop_and_hide_video(get_node("/root/chest/Remaster/Control/VideoStreamPlayerChestClosed"))
				await self.start_show_then_hide_video(get_node("/root/chest/Remaster/Control/VideoStreamPlayerChestOpening"))
			set_text("You open the treasure chest and guess what? Find a treasure!")
			Global.update_scene_state("chest opened")
			load_scene_config()
		"TAKECOINS":
			Global.take_item_and_animate("Remaster", "Money", 92, 238, NAN, 1.0, 1.0)
			Global.take_item_and_animate("Original", "Money", 245, 229)
			load_scene_config()
		"EXIT":
			Global.set_scene("vessel")
		_:
			print("Action not recognized in this scene")
