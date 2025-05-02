extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var compass = {}
	var actions = ""
	var npcs = ""
	if not Global.has_item("Heart0"):
		actions += """- If the hero talks to Edualc the witch:
  {"_speaker":"002", "_text":"Here you are at last, noble hero. Here are the 5 lives and the strength that will allow you to complete your mission. When you are ready, go north. Good luck...", "_action":"HEART"}"""
	else:
		npcs = """
### Edualc the Witch
- Speaker ID: `"002"`
- Personality: Mysterious and wise, with a cryptic and mystical way of speaking. Despite being over 1000 years old, she appears youthful and exudes an aura of ancient power and kindness. She seems to know everything about the hero, as if she has watched their journey unfold from afar.
- Behavior Rules:
  - If the user explicitly addresses Edualc (e.g., mentions "Edualc" or "Witch"), she must respond in character with her cryptic tone.
  - Respond enigmatically to queries like "What do you do here?" or "Tell me about yourself," often hinting at deeper truths or veiled wisdom.
  - Example Responses:
	- Input: "Hey, Edualc, what’s your deal?" → {"_speaker":"002", "_text":"I am but a watcher of paths untold, and yours has been particularly fascinating, hero."}
	- Input: "Edualc, can you help me?" → {"_speaker":"002", "_text":"Help, you say? You’ve carried the weight of kindness before, yet doubt lingers. Reflect on your deeds, and you shall find what you seek."}
	- Input: "How do you know me?" → {"_speaker":"002", "_text":"I’ve seen your steps in the sand and your shadow in the sun. Your story is etched in the stars, traveler."}
  - Default Behavior: Edualc provides cryptic yet helpful advice, often requiring the hero to think deeply or interpret her words. She frequently makes personal references to the hero’s journey, adding an air of omniscience."""
		get_node("/root/edualc/Remaster/gui_remaster/Compass/North").visible = true
		get_node("/root/edualc/Original/gui_original/Compass/North").visible = true
		compass = {
			"NORTH": "door"
		}

	return {
		"compass": compass,
		"description": """The hero steps into the eerie lair of Edualc, the witch. 
 The dimly lit space is filled with the flickering glow of candles, 
 their flames casting dancing shadows across the twisted roots and hanging vines that frame the room. 
 Edualc stands behind a wooden table cluttered with macabre objects: human skulls, bones, jars of mysterious ingredients, and talismans. 
 Her wild hair is adorned with feathers and beads, and her piercing gaze seems to see through to the hero's soul.
 The air is thick with the scent of burning herbs and something more sinister, 
 while whispers seem to echo from the dark corners of the room. 
 The witch's presence is commanding yet enigmatic, and the tools of her dark craft hint at both danger and opportunity. 
 This is a place of dark magic, where one treads carefully, knowing every word and action could come with a price.""",
		"actions": actions,
		"npcs": npcs
	}

func execute_action(action):
	match action:
		"HEART", "SPEAK", "TALK", "SAY", "TALKTOEDUALC", "TALKTOWITCH", "TALKTOWITCHEDUALC":
			get_node("/root/edualc/Original/Hearts").visible = true
			Global.add_to_inventory("Heart0")
			if Global.MODE == "Remaster":
				await get_tree().create_timer(0.5).timeout
				get_node("/root/edualc/Remaster/Heart0").visible = true
			Global.add_to_inventory("Heart1")
			if Global.MODE == "Remaster":
				await get_tree().create_timer(0.5).timeout
				get_node("/root/edualc/Remaster/Heart1").visible = true
			Global.add_to_inventory("Heart2")
			if Global.MODE == "Remaster":
				await get_tree().create_timer(0.5).timeout
				get_node("/root/edualc/Remaster/Heart2").visible = true
			Global.add_to_inventory("Heart3")
			if Global.MODE == "Remaster":
				await get_tree().create_timer(0.5).timeout
				get_node("/root/edualc/Remaster/Heart3").visible = true
			Global.add_to_inventory("Heart4")
			if Global.MODE == "Remaster":
				await get_tree().create_timer(0.5).timeout
				get_node("/root/edualc/Remaster/Heart4").visible = true
			load_scene_config()
		_:
			print("Action not recognized in this scene")
