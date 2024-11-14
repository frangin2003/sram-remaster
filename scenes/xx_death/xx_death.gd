extends "res://scenes/BaseScene.gd"

func _get_scene_config() -> Dictionary:
	CommandHandler.CURRENT_HANDLER = null
	Global.reset_inventory()
	return {
		"compass": {
			"NORTH": null,
			"EAST": null,
			"SOUTH": null,
			"WEST": null
		},
	}

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode != KEY_F1 and event.keycode != KEY_ESCAPE:
			Global.reset_scene_state()
			Global.set_scene("menhir")
