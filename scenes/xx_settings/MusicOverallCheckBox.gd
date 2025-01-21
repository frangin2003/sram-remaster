extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	toggled.connect(_on_button_toggled)

# Called when the button is toggled
func _on_button_toggled(pressed_state: bool):
	Global.update_sound(pressed_state)
