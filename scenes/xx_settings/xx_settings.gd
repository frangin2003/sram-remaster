extends Control

# If your popup is a direct child of this control
@onready var popup = $MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#popup.hide()
	

func _input(event):
	if event.is_action_pressed("show_settings"):
		popup.visible = !popup.visible
		get_viewport().set_input_as_handled()


func _on_close_texture_button_button_down():
	popup.visible = false


func _on_exit_texture_button_button_down():
	get_tree().quit()
