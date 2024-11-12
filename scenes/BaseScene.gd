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
	Global.SCENE = Global.get_current_scene_name()

	var config = _get_scene_config()
	
	# Set compass (optional)
	if config.has("compass"):
		Global.set_compass(config.compass)
	
	# Set description (optional)
	if config.has("description"):
		Global.SCENE_DESCRIPTION = config.description
	
	# Set actions (optional)
	if config.has("actions"):
		Global.ACTIONS = config.actions
	
	# Set NPCs (optional)
	if config.has("npcs"):
		Global.NPCS = config.npcs
		
	# Set background image
	Global.set_original_background_image()
