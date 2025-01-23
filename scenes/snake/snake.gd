extends "res://scenes/BaseScene.gd"

var time_to_wait = 0.0
var timer_started = 0.0

func _process(_delta):
	var audio_player = get_node("/root/snake/Remaster/AudioStreamPlayerHissing")
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if time_to_wait == 0.0:
		# Initial setup of wait time
		time_to_wait = randf_range(4.0, 8.0)
		timer_started = current_time
	
	if not audio_player.playing and (current_time - timer_started >= time_to_wait):
		audio_player.play()
		# Set up next wait interval
		time_to_wait = randf_range(4.0, 8.0)
		timer_started = current_time

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	var description = """The scene unfolds with an eerie, otherworldly aura as you stand on the edge of the murky swamps, 
 gazing at a sinister island in the distance. 
 The island is shrouded in thick mist, and the only sounds are the unsettling hisses and the faint rustling of scales against foliage. 
 This is Snake Island—a dangerous haven teeming with slithering serpents of all shapes and sizes. 
 The trees on the island twist unnaturally, their branches serving as resting places for venomous vipers, 
 while the ground is covered in a writhing carpet of snakes.
 The swamp waters separating you from the island churn ominously, and you spot the glint of crocodile eyes lurking just beneath the surface, 
 making swimming to the island impossible. A sturdy liane dangles invitingly from a nearby tree, swaying gently in the humid breeze, 
 offering a precarious hope of swinging over the treacherous waters to the island. 
 The air is thick with tension, and every step forward feels like a gamble with danger."""
	var actions = ""
	if Global.has_state("killed"):
		self.stop_and_hide_video(get_node("/root/snake/Remaster/Control/VideoStreamPlayer"))
		self.start_loop_and_show_video(get_node("/root/snake/Remaster/Control/VideoStreamPlayerDeadSnake"))
		get_node("/root/snake/Original/Background").texture = load("res://scenes/snake/snake.png")

		if not Global.has_item("skin"):
			if Global.has_item("knife"):
				description += """ You can now skin the snake and take its skin as a trophy."""
				actions = """- If the hero takes the snake skin:
	{"_speaker":"001", "_text":"Another trophy for your collection.", "_action":"SKIN"}"""
			else:
				actions = """- If the hero wants the snake skin:
	{"_speaker":"001", "_text":"You need a knife to skin it.", "_action":"NOPE"}"""
	else:
		if Global.has_item("cane"):
			actions = """- If the hero attacks the snake with the cane:
	{"_speaker":"001", "_text":"You killed it.", "_action":"KILL"}"""	
		else:
			actions = """- If the hero attacks the snake with the cane:
	{"_speaker":"001", "_text":"You need a cane to kill it.", "_action":"NOPE"}"""

	return {
		"compass": {
			"WEST": "bridge"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	print("Action: " + action)
	match action:
		"KILL":
			if Global.MODE == "Remaster":
				await self.start_show_then_hide_video(get_node("/root/snake/Remaster/Control/VideoStreamPlayerSnakeAttack"))
			Global.update_scene_state("killed")
			load_scene_config()

		"SKIN":
			get_node("/root/snake/Remaster/Skin").visible = true
			get_node("/root/snake/Original/Skin").visible = true

			Global.take_item_and_animate("Remaster", "Skin", 1807, 526)
			Global.take_item_and_animate("Original", "Skin", 1626, 598)

			load_scene_config()
		_:
			print("Action not recognized in this scene")

