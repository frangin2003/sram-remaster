extends "res://scenes/BaseScene.gd"

var time_to_wait = 0.0
var timer_started = 0.0
var leaf_tween: Tween = null

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
	
	var leaf = get_node("/root/hogg/Remaster/Leaf")
	if leaf and (leaf_tween == null or not leaf_tween.is_valid()):
		animate_leaf(leaf)

func animate_leaf(leaf: Node2D):
	leaf_tween = create_tween()
	var random_rotation = randf_range(3.0, 6.0)
	var base_rotation = 108.7
	var base_position = leaf.position
	var offset = 10.0  # Horizontal movement in pixels
	
	# First tween: Rotate and move to +rotation and +offset
	leaf_tween.tween_property(leaf, "rotation_degrees", base_rotation + random_rotation, 1.2)
	leaf_tween.tween_property(leaf, "position:x", base_position.x + offset, 1.2)
	leaf_tween.set_parallel(true)
	leaf_tween.set_trans(Tween.TRANS_SINE)
	leaf_tween.set_ease(Tween.EASE_IN_OUT)
	
	# Chain the next tween: Rotate and move to -rotation and -offset
	leaf_tween.tween_property(leaf, "rotation_degrees", base_rotation - random_rotation, 1.2)
	leaf_tween.tween_property(leaf, "position:x", base_position.x - offset, 1.2)
	leaf_tween.set_parallel(true)
	leaf_tween.set_trans(Tween.TRANS_SINE)
	leaf_tween.set_ease(Tween.EASE_IN_OUT)
	
	# Chain the final tween: Rotate and move back to base
	leaf_tween.tween_property(leaf, "rotation_degrees", base_rotation, 1.2)
	leaf_tween.tween_property(leaf, "position:x", base_position.x, 1.2)
	leaf_tween.set_parallel(true)
	leaf_tween.set_trans(Tween.TRANS_SINE)
	leaf_tween.set_ease(Tween.EASE_IN_OUT)
	
	# Connect the tween to loop the animation
	leaf_tween.finished.connect(func(): animate_leaf(leaf))

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
