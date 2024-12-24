extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	# Connect the signal from HeroTextEdit
	var hero_text_edit = get_node("/root/lutin/Remaster/gui_remaster/HeroTextEdit")
	hero_text_edit.connect("speak_seconds", speak_seconds)
	ActionHandler.CURRENT_HANDLER = self
	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": "tree"
		},
		"description": "You are standing by a wide, flowing river. A cheerful Leprechaun with a mischievous grin blocks your path.",
		"npcs": """
### Fergus Floodgate (Leprechaun)
- Speaker ID: `"003"`
- Personality: Mischievous and funny, with a thick Irish accent.
- Behavior Rules:
  - If the user explicitly addresses Fergus (e.g., mentions "Fergus" or "Leprechaun"), he must respond in character.
  - Respond conversationally to generic queries like "What do you do here?" or "Tell me about this river."
  - Example Responses:
	- Input: "Hey, Fergus, what’s your deal?" → {"_speaker":"003", "_text":"Me deal? Guardin' this river and makin' sure nosy heroes like yerself don’t pass without me permission!"}
	- Input: "Leprechaun, what’s the secret to crossing?" → {"_speaker":"003", "_text":"Ah, that’d be tellin', wouldn’t it? Give me the hermit potion, and we’ll see!"}
  - Default Behavior: Fergus responds humorously to casual inputs, but refuses to reveal critical information unless specific triggers (e.g., "hermit potion") are met.""",
  "actions": """
- If the hero attempts to kill the leprechaun:
  {"_speaker":"001", "_text":"By killing him, you killed yourself, genius. He was key for your adventure to continue.", "_action":"DEATH"}"""
	}

func speak_seconds(speaker, seconds):
	Global.speak_seconds(speaker, seconds)

func execute_action(action):
	print("Action: " + action)
	match action:
		"003":
			Global.take_item_and_animate("Remaster", "Potion", 112, 616)
		_:
			print("Action not recognized in this scene")
