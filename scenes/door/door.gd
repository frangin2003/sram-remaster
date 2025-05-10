extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("Original/gui_original/SceneDescription").text = """YOU ARE BEFORE
A WELL-GUARDED DOOR"""

	var description = """The hero stands before the imposing door of the secret prison where King Egres IV is held captive.
 The massive wooden door, reinforced with iron bands, looms beneath a grand stone archway, 
 its surface weathered and marked with holes that resemble eerie faces. Two skeletal sentinels stand guard on either side, 
 their bony fingers clutching ancient staffs, their hollow eyes fixed in a perpetual gaze. 
 Tattered cloaks hang from their frames, blending with the cobwebs that cling to the edges of the doorway. 
 At the base of the door lies a worn doormat embroidered with the chilling word "Hell-O", a mocking welcome to the grim prison. 
 Shadows play across the scene, hinting at the dark secrets locked away behind this foreboding entrance."""

	var actions = ""
	if Global.has_state("doormat lifted"):
		description += "The doormat is lifted now."
		get_node("/root/door/Remaster/Carpet").visible = false
		get_node("/root/door/Remaster/CarpetFolded").visible = true
		if not Global.has_item("Key"):
			description += "You find a key under the doormat."
			description += "The hero can't open the door."
			description += "The hero can't enter the prison."
			Global.show_item("Key")
			actions += """- If the hero is taking the key:
	{"_speaker":"001", "_text":"You take the key.", "_action":"KEY"}"""
		else:
			if Global.has_state("door opened"):
				get_node("/root/door/Remaster/Background").texture = load("res://scenes/door/door_open.webp")
				get_node("/root/door/Original/Background").texture = load("res://scenes/door/door_open.png")
				description += "The door is now opened."
				actions += """- If the hero is getting through the door:
	{"_speaker":"001", "_text":"", "_action":"ENTER"}"""
			else:
				description += "The hero can't enter the prison."
				actions += """- If the hero is opening the door with the key:
	{"_speaker":"001", "_text":"You open the door with the key.", "_action":"OPEN"}"""
	else:
		description += "The hero can't open the door."
		description += "The hero can't enter the prison."
		actions += """- If the hero is lifting the doormat:
	{"_speaker":"001", "_text":"You lift the doormat and find a key.", "_action":"DOORMAT"}"""

	return {
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"ENTER":
			Global.set_scene("prisoners")
		"OPEN", "OPENED", "DOOR_OPEN", "DOOR_OPENED":
			if Global.MODE == "Remaster":
				await self.start_show_then_hide_video(get_node("/root/door/Remaster/Control/VideoStreamPlayerOpenDoor"))
			Global.update_scene_state("door opened")
			load_scene_config()
		"DOORMAT":
			Global.update_scene_state("doormat lifted")
			load_scene_config()
		"KEY":
			Global.take_item_and_animate("Remaster", "Key", 1822, 264)
			Global.take_item_and_animate("Original", "Key", 1636, 265)
			load_scene_config()
		_:
			print("Action not recognized in this scene")
