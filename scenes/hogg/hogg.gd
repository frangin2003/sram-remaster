extends "res://scenes/BaseScene.gd"

var time_to_wait = 0.0
var timer_started = 0.0

func _process(_delta):
	var audio_player = get_node("/root/hogg/Remaster/AudioStreamPlayerGrunt")
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
	Global.show_hide_item("Leaf")
	var description = """The hero stands amidst a tranquil forest, where sunlight streams through the tall, ancient trees, 
 casting golden patterns on the moss-covered ground. 
 The air is thick with serenity, broken only by the rustle of leaves and distant bird calls. 
 In the midst of this calm, a massive boar locks eyes with the hero, its posture steady and watchful. 
 Though the scene is peaceful, the boar's gaze feels like a silent challenge, testing the hero's resolve."""
	var actions = """
- If the hero attempts to take the bow:
  {"_speaker":"001", "_text":"Now you need an arrow.", "_action":"BOW"}"""
	if not Global.has_item("Leaf"):
		description += " Nearby, a beautiful oak leaf, vibrant and perfect, hangs delicately from a low branch, swaying gently in the soft breeze."
		actions += """- If the hero is taking the leaf:
  {"_speaker":"001", "_text":"Well, a beautiful leaf, keep it.", "_action":"LEAF"}"""
	return {
		"compass": {
			"NORTH": "bird",
			"EAST": "bridge",
			"SOUTH": "pond",
			"WEST": "druids"
		},
		"description": description,
		"actions": actions
	}

func execute_action(action):
	match action:
		"LEAF":
			Global.take_item_and_animate("Remaster", "Leaf", 112, 616)
			Global.take_item_and_animate("Original", "Leaf", 282, 659)
		_:
			print("Action not recognized in this scene")
