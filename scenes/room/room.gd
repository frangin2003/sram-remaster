extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = ""
	var actions = ""
	if not Global.has_state("tidy"):
		description = """The hermit's room is a chaotic mess of scattered papers, overturned objects, and tattered furnishings. 
 The dim light filtering through the wooden panels highlights the disorganized state of the room, with a cluttered table and makeshift bedding in the corner. 
 The air is thick with a putrid stench, making it hard to breathe, and swarms of flies buzz incessantly around, drawn to the overwhelming filth. 
 Despite the mess, the room exudes a strange charm, with remnants of a rustic life evident in the old radio on the table and the simple, weathered decor."""
		actions = """- If the hero tidies up: 
  {"_speaker":"002", "_text":"Thanks a lot for the cleaning, I've been meaning to do this for ages. Here's something for you, when facing the lycanthrope say: `You have beautiful eyes you know`", "_action":"TIDY"}"""
	else:
		self.stop_and_hide_video(get_node("/root/room/Remaster/Control/VideoStreamPlayer"))
		self.start_loop_and_show_video(get_node("/root/room/Remaster/Control/VideoStreamPlayerTidy"))
		get_node("/root/room/Original/Background").texture = load("res://scenes/room/room_tidy.png")
		var music_node = get_node("/root/room/Remaster/AudioStreamPlayer")
		music_node.stream = load("res://scenes/room/outlaw-country-2-132052.mp3")#
		music_node.play()
		get_node("/root/room/Remaster/MusicNotes").visible = true
		description = """The hermit's room now radiates warmth and comfort, transformed after a thorough cleaning. 
 The wooden floors gleam, free of clutter, and the air is fresh and fragrant with the subtle scent of flowers. 
 The bed is neatly made, and the scattered papers and debris have been tidied away, leaving the space organized and serene. 
 Gentle sunlight streams through the window, adding a cozy glow. In the corner, the old portable radio softly plays smooth country music, setting a relaxed and homely atmosphere. 
 The once chaotic space now feels inviting, a testament to the hero's hard work."""
		set_text("Thanks a lot, I've been meaning to do this for ages. Here is something for you, when facing the lycanthrope say: `You have beautiful eyes you know`")

	return {
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"TIDY":
			Global.update_scene_state("tidy")
			Global.set_scene("room")
		_:
			print("Action not recognized in this scene")
