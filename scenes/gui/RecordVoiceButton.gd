extends Button

signal audio_recording_started
signal audio_recording_stopped

var icon_texture_record = load("res://scenes/gui/record_button.png")
var icon_texture_stop = load("res://scenes/gui/stop_button.png")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	icon = icon_texture_record
	#connect("mouse_entered", _on_Button_mouse_entered)
	#connect("mouse_exited", _on_Button_mouse_exited)
	#connect("pressed", _on_Button_pressed)
	
func _on_Button_pressed():
	if (icon == icon_texture_record):
		emit_signal("audio_recording_started")
		icon = icon_texture_stop
	else:
		emit_signal("audio_recording_stopped")
		icon = icon_texture_record

func _on_Button_mouse_entered():
	scale = Vector2(0.97, 0.97) # Shrink the button slightly

func _on_Button_mouse_exited():
	scale = Vector2(1, 1) # Return to original size

