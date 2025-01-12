extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = """The scene shows the Ermit, a large, jovial man with a bushy white beard and a warm smile, standing confidently in front of his rustic wooden house. 
 His simple clothing, complete with suspenders, adds to his humble and approachable demeanor. 
 The house behind him is weathered but sturdy, with planks leaning against it and a bucket nearby, giving the impression of a peaceful, self-sufficient life in the countryside. 
 The surrounding open landscape adds a serene and welcoming atmosphere.
 **Key Note**: The hermit must provide the list of ingredients required to craft the potion during the first interaction. This information is critical for the hero’s progression and must not be missed."""
	var actions = """- If the hero enters the hermit's house:
  {"_speaker":"004", "_text":"My home is your home, if you don't mind the smell.", "_action":"HOUSE"}"""
	var npcs = """
### The Hermit
- Speaker ID: `"004"`
- Personality: Wise, old, and smelly. Despite his gruff demeanor, he holds critical knowledge for the hero's journey.
- Behavior Rules:
  - **Mandatory Initial Interaction**: During the first interaction, the hermit must provide the list of ingredients required for the potion. He should integrate this information naturally into his dialogue, delivering it in his usual wise but cryptic tone.
	- Example Response: "Ah, you’ll need boar fur, oak leaf, water lily, snake scale, werewolf ear, turtle egg, and centaur hoof to make the potion. Remember, no shortcuts in magic!"
  - After the first interaction, the hermit can respond to the hero with general advice or additional cryptic remarks but will repeat the ingredient list if explicitly asked.
	- Example Response: "Forgot already? Boar fur, oak leaf, water lily, snake scale, werewolf ear, turtle egg, centaur hoof. Keep up!"
  - Responds with humor or cryptic wisdom to casual inputs.
  - If the hero insults him, he might retort with a sharp comment or dismiss the insult entirely."""

	if not Global.has_item("Flute"):
		description += " A flute is tucked into his front pocket, hinting at a musical side to his character."
		actions += """- If the hero attempts to take the flute:
  {"_speaker":"004", "_text":"I'll give it to you if you solve this riddle: What walks on four legs in the morning, two legs at noon, and three legs in the evening?", "_action":"RIDDLE"}
- If the hero correctly answers the riddle (e.g., "man" or similar):
  {"_speaker":"004", "_text":"The flute is yours now, play it in the centaur forest.", "_action":"FLUTE"}"""
	else:
		get_node("/root/hermit/Remaster/ErmitFlute").visible = false
		get_node("/root/hermit/Original/Flute").visible = false

	if not Global.has_state("talked once to hermit"):
		actions += """- If the hero talks to the hermit:
  {"_speaker":"004", "_text":"Hello there my friend. I am the hermit and I do very good potions that delights Leprechaun. For it, you’ll need boar fur, oak leaf, water lily, snake scale, werewolf ear, turtle egg, and centaur hoof. Remember, no shortcuts in magic!", "_action":"TALK"}"""

	if Global.has_item("Fur") and Global.has_item("Leaf") and Global.has_item("Lilipad") and Global.has_item("Skin") and Global.has_item("Ear") and Global.has_item("Eggs") and Global.has_item("Hoof"):
		actions += """- If the hero gives the ingredients to the hermit:
  {"_speaker":"004", "_text":"Here is the potion for you. Give it to the Leprechaun. Good luck my friend.", "_action":"POTION"}"""
		npcs += """  - Now that the hero has the ingredients, give him the potion when he gives the ingredients."""
	if Global.has_item("Potion"):
		npcs += """  - If asks about the potion, the hermnit repeats that it needs to be given to the Leprechaun."""

	return {
		"compass": {
			"WEST": "signpost"
		},
		"description": description,
		"actions": actions,
		"npcs": npcs
	}

func execute_action(action):
	match action:
		"TALK":
			Global.update_scene_state("talked once to hermit")
			load_scene_config()
		"FLUTE":
			get_node("/root/hermit/Remaster/ErmitFlute").visible = false
			get_node("/root/hermit/Remaster/Flute").visible = true
			Global.take_item_and_animate("Remaster", "Flute", 128, 387)
			Global.take_item_and_animate("Original", "Flute", 287, 395)
			load_scene_config()
		"HOUSE":
			Global.set_scene("room")
		"POTION":
			Global.remove_from_inventory("Fur")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Fur").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Fur").visible = false
			Global.remove_from_inventory("Leaf")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Leaf").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Leaf").visible = false
			Global.remove_from_inventory("Lilipad")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Lilipad").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Lilipad").visible = false
			Global.remove_from_inventory("Skin")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Skin").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Skin").visible = false
			Global.remove_from_inventory("Ear")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Ear").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Ear").visible = false
			Global.remove_from_inventory("Eggs")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Eggs").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Eggs").visible = false
			Global.remove_from_inventory("Hoof")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Hoof").visible = false
			get_node("/root/hermit/Original/gui_original/Inventory/Hoof").visible = false
			Global.remove_from_inventory("Potion")
			get_node("/root/hermit/Remaster/gui_remaster/Inventory/Potion").visible = true
			get_node("/root/hermit/Original/gui_original/Inventory/Potion").visible = true
			load_scene_config()
		_:
			print("Action not recognized in this scene")
