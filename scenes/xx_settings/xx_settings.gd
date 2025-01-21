extends Control

# If your popup is a direct child of this control
@onready var popup = $MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	# pass
	popup.hide()
	popup.visibility_changed.connect(_on_popup_visibility_changed)
	
func _on_close_texture_button_button_down():
	popup.visible = false


func _on_exit_texture_button_button_down():
	get_tree().quit()

func _on_popup_visibility_changed():
	if popup.visible:
		var checkbox_overall = $MarginContainer/Panel/MusicOverallCheckBox
		var checkbox_original = $MarginContainer/Panel/MusicOriginalCheckBox
		
		# Block signals before setting button state
		checkbox_overall.set_block_signals(true)
		checkbox_original.set_block_signals(true)
		
		# Set button states
		checkbox_overall.button_pressed = Global.SOUND
		checkbox_original.button_pressed = Global.SOUND_ORIGINAL
		
		# Unblock signals after setting button state
		checkbox_overall.set_block_signals(false)
		checkbox_original.set_block_signals(false)
