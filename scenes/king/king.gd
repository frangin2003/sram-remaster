extends "res://scenes/BaseScene.gd"

var intro_video
var loop_video
var video_state = "intro"  # States: "intro", "loop", "done"
var start_time = 0.0
var can_skip = false

func _process(_delta):
	var current_time = Time.get_ticks_msec() / 1000.0
	if not can_skip and (current_time - start_time >= 20.0):
		set_text("** PRESS ANY KEY TO GO BACK TO THE TITLE SCREEN. **")
		can_skip = true
	
	if video_state == "intro" and (current_time - start_time >= 2.0):
		intro_video.visible = false
		loop_video.visible = true
		video_state = "loop"
		get_node("/root/king/Original/Background").texture = load("res://scenes/king/knight.png")
		set_text("The King knights you! Bravo, noble knight, you have successfully completed this perilous mission.")

func _input(event):
	if can_skip and event is InputEventKey and event.pressed:
		Global.set_scene("title_screen")

func _get_scene_config() -> Dictionary:
	ActionHandler.CURRENT_HANDLER = self
	get_node("/root/king/Remaster/gui_original/HeroTextEdit")
	intro_video = get_node("/root/king/Remaster/Control/VideoStreamPlayerKing")
	start_time = Time.get_ticks_msec() / 1000.0
	intro_video = get_node("/root/king/Remaster/Control/VideoStreamPlayerKing")
	loop_video = get_node("/root/king/Remaster/Control/VideoStreamPlayerKnight")
	intro_video.visible = true
	loop_video.visible = false
	set_text("Glory! The King is back!")
	return {}

