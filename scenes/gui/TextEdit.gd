extends TextEdit

#var socket = WebSocketPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure the TextEdit can focus to receive key inputs.
	set_focus_mode(FOCUS_ALL)
	LlmServer.connect("llm_output_added", llm_output_added)

func _process(delta):
	pass

func llm_output_added(new_output):
	get_node("../Output").text = new_output
	if "PIG TIME" in get_node("../Output").text :
		get_node("../Output").text = ''
		get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")

# Override _gui_input instead of _input for GUI elements like TextEdit.
func _gui_input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed and key_event.keycode == KEY_ENTER:
			var user_message = text # Get the text from the TextEdit
			var system_message = """You are acting as the game master (gm) of an epic adventure.
# Guidelines
- You speak very funnily.
- You only answer with ONE SHORT sentence, NO EMOJIS.
- If the hero is insulting you only answer "PIG TIME".
- Complete the below interaction."""
			clear()
			get_node("../Output").text = ''
			LlmServer.send_text(system_message, user_message)
			get_viewport().set_input_as_handled()
