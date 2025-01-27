extends "res://scenes/BaseScene.gd"

var time_to_wait = 0.0
var timer_started = 0.0
var leaf_tween: Tween = null
var should_animate = true

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
	if not should_animate:
		return
		
	leaf_tween = create_tween()
	var random_rotation = randf_range(3.0, 6.0)
	var base_rotation = 108.7
	var base_position = leaf.position
	var offset = 10.0
	
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
	
	leaf_tween.finished.connect(func(): 
		if should_animate:  # Only continue if should_animate is true
			animate_leaf(leaf)
	)

func init_scene():
	ActionHandler.CURRENT_HANDLER = self
	if Global.has_item("Leaf") or Global.has_state("leaf given"):
		Global.hide_item("Leaf")
	else:
		Global.show_item("Leaf")

	if Global.has_item("Fur") or Global.has_state("fur given"):
		Global.hide_item("Fur")
	else:
		Global.show_item("Fur")

func _get_scene_config() -> Dictionary:
	var description = """The hero stands amidst a tranquil forest, where sunlight streams through the tall, ancient trees, 
 casting golden patterns on the moss-covered ground. 
 The air is thick with serenity, broken only by the rustle of leaves and distant bird calls. 
 In the midst of this calm, a massive boar locks eyes with the hero, its posture steady and watchful. 
 Though the scene is peaceful, the boar's gaze feels like a silent challenge, testing the hero's resolve.
 Like all boars, this one has a particular fondness for acorns, a delicacy of the forest."""
	var actions = """- If the hero is attacking the boar:
{"_speaker":"001", "_text":"", "_action":"ATTACK"}"""
	if not Global.has_item("Leaf") and not Global.has_state("leaf given"):
		description += " Nearby, a beautiful oak leaf, vibrant and perfect, hangs delicately from a low branch, swaying gently in the soft breeze."
		actions += """- If the hero is taking the leaf:
	{"_speaker":"001", "_text":"Well, a beautiful leaf, keep it.", "_action":"LEAF"}"""

	if not Global.has_item("Fur"):
		actions += """- If the hero is giving an acorn to the boar:
	{"_speaker":"001", "_text":"To thank you, it gives you some fur.", "_action":"FUR"}"""
	elif not Global.has_state("fur given"):
		get_node("/root/hogg/Remaster/Fur").visible = true
		get_node("/root/hogg/Original/Fur").visible = true

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
			should_animate = false  # Stop the animation loop
			if leaf_tween and leaf_tween.is_valid():
				leaf_tween.kill()
				leaf_tween = null
			await Global.take_item_and_animate("Remaster", "Leaf", 1856, 456)
			await Global.take_item_and_animate("Original", "Leaf", 1643, 505)
			load_scene_config()
		"FUR":
			if Global.MODE == "Remaster":
				get_node("/root/hogg/Remaster/Acorn").visible = false
				await self.start_show_then_hide_video(get_node("/root/hogg/Remaster/Control/VideoStreamPlayerFeedBoar"))
				get_node("/root/hogg/Remaster/Acorn").visible = true
			Global.add_to_inventory("Fur")
			load_scene_config()
		"ATTACK":
			if Global.MODE == "Remaster":
				await self.start_show_then_hide_video(get_node("/root/hogg/Remaster/Control/VideoStreamPlayerBoarAttack"))
			Global.set_scene("xx_death")
		_:
			print("Action not recognized in this scene")

func _on_leaf_tween_finished():
	# This function is called when the tween finishes
	animate_leaf(get_node("/root/hogg/Remaster/Leaf"))

