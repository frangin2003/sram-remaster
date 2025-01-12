extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	if Global.has_state("centaur"):
		self.stop_and_hide_video(get_node("/root/centaur/Remaster/Control/VideoStreamPlayer"))
		self.start_loop_and_show_video(get_node("/root/centaur/Remaster/Control/VideoStreamPlayerCentaur"))
		get_node("/root/centaur/Original/Background").texture = load("res://scenes/centaur/centaure.png")
	else:
		self.stop_and_hide_video(get_node("/root/centaur/Remaster/Control/VideoStreamPlayerCentaur"))
		self.start_loop_and_show_video(get_node("/root/centaur/Remaster/Control/VideoStreamPlayer"))
		get_node("/root/centaur/Original/Background").texture = load("res://scenes/centaur/centaure_pasla.png")

	var description = """The hero enters the mystical Centaur Forest, where towering trees form a natural tunnel,
 their trunks wrapped in vibrant green vines. Sunbeams filter through the canopy, casting golden light onto the lush,
 grassy path that stretches endlessly ahead. Hoofprints are embedded in the soft dirt trail, their shape unmistakably belonging to centaurs.
 The forest is alive with a quiet, otherworldly energy, the air thick with the scent of earth and greenery.
 In the distance, the path seems to fade into a soft glow, hinting at secrets yet to be uncovered."""
	var actions = ""
	var npcs = ""
	if Global.has_item("flute"):
		actions = """
- If the hero attempts to play the flute:
  {"_speaker":"001", "_text":"", "_action":"PLAYFLUTE"}"""
	if Global.has_state("centaur"):
		description += """A proud centaur is facing you, his muscular frame glistening in the sunlight. With a confident smirk, he proclaims,
“I’ll never let you down!”."""
		npcs = """
### Rick the Centaur
- Speaker ID: `"007"`
- Personality: Majestuous and imposing, strangely a Rick Astley lookalike.
- Behavior Rules:
  - If the user explicitly addresses Rick (e.g., mentions "Rick" or "Centaur"), he must respond in character.
  - Respond conversationally to generic queries like "What do you do here?" or "Tell me about yourself."
  - Example Responses:
	- Input: "Hey, Rick, what’s your deal?" → {"_speaker":"007", "_text":"Wandering through the forest, feeling empty handed right now!"}
	- Input: "Rick, have you lost something?" → {"_speaker":"007", "_text":"I am one bow and one arrow down!"}
  - Default Behavior: Rick responds humorously to casual inputs, but never misses the opportunity to complain about how much he misses his bow and arrow."""
		if not Global.has_item("hoof"):
			if Global.has_item("bow"):
				actions += """
- If the hero is giving the bow:
  {"_speaker":"007", "_text":"Thank you! I’ll never give it up!", "_action":"GIVEBOW"}"""
			if Global.has_item("arrow"):
				actions += """
- If the hero is giving the arrow:
  {"_speaker":"007", "_text":"Thank you! I won't have to run around and look for it anymore!", "_action":"GIVEARROW"}"""
	return {
		"compass": {
			"NORTH": "desert_1",
			"EAST": "west_bank",
		},
		"description": description,
		"actions": actions,
		"npcs": npcs
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"PLAYFLUTE":
			if Global.MODE == "Remaster":
				self.stop_and_hide_video(get_node("/root/centaur/Remaster/Control/VideoStreamPlayer"))
				await self.start_show_then_hide_video(get_node("/root/centaur/Remaster/Control/VideoStreamPlayerPlayFlute"))
			set_text("Rick the centaur appears before you. He looks at you with a confident smirk.")
			Global.update_scene_state("centaur")
			load_scene_config()
		"GIVEBOW":
			Global.update_inventory("Bow", false)
			Global.update_scene_state("bow given")
			if Global.has_state("arrow given"):
				get_node("/root/centaur/Remaster/Hoof").show()
				get_node("/root/centaur/Original/Hoof").show()
				set_text("Thanks a lot, please take this, it's a spare hoof that might come in handy.")
				await Global.take_item_and_animate("Remaster", "Hoof", 1846, 675)
				await Global.take_item_and_animate("Original", "Hoof", 1666, 741)
			Global.set_scene("centaur")
		"GIVEARROW":
			Global.update_inventory("Arrow", false)
			Global.update_scene_state("arrow given")
			if Global.has_state("bow given"):
				get_node("/root/centaur/Remaster/Hoof").show()
				get_node("/root/centaur/Original/Hoof").show()
				set_text("Thanks a lot, please take this, it's a spare hoof that might come in handy.")
				await Global.take_item_and_animate("Remaster", "Hoof", 1846, 675)
				await Global.take_item_and_animate("Original", "Hoof", 1666, 741)
			Global.set_scene("centaur")
		_:
			print("Action not recognized in this scene")
