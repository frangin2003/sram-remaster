extends Node2D

# Virtual method to be overridden by child scenes
func _get_scene_config() -> Dictionary:
	return {
		"name": "",  # Scene name (required)
		"compass": {  # Compass configuration (optional)
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": null
		},
		"description": "",  # Scene description (optional)
		"actions": "",  # Available actions (optional)
		"npcs": ""  # NPCs in the scene (optional)
	}

func _ready():
	SwitchMode.update_mode_visibility()
	Global.SCENE = Global.get_current_scene_name()
	if not Global.LOADED_USER_STATE:
		Global.load_user_state()

	var config = _get_scene_config()
	
	# Set compass (optional)
	var compass = {}
	if config.has("compass"):
		compass = config.compass
	Global.set_compass(compass)

	# Set system (optional)
	if config.has("system_override"):
		Global.SYSTEM_OVERRIDE = config.system_override
	
	# Set description (optional)
	if config.has("description"):
		Global.SCENE_DESCRIPTION = config.description
	
	# Set actions (optional)
	if config.has("actions"):
		Global.ACTIONS = config.actions
	
	# Set NPCs (optional)
	if config.has("npcs"):
		Global.NPCS = config.npcs

func setText(text: String):
	var remaster_output = get_node("/root/%s/Remaster/gui_remaster/GameMasterBackground/GameMasterOutput" % Global.SCENE)
	var original_output = get_node("/root/%s/Original/gui_original/GameMasterBackground/GameMasterOutput" % Global.SCENE)
	remaster_output.text = text
	original_output.text = text

func stop_and_hide_video(video_player: VideoStreamPlayer):
	video_player.stop()
	video_player.hide()

func start_show_then_hide_video(video_player: VideoStreamPlayer):
	video_player.set_loop(false)
	video_player.play()
	video_player.show()
	await video_player.finished
	video_player.hide()

func start_loop_and_show_video(video_player: VideoStreamPlayer):
	video_player.play()
	video_player.set_loop(true)
	video_player.show()
