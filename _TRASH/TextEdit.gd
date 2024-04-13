extends TextEdit

#var socket = WebSocketPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	LlmServer.connect("llm_chunk", llm_chunk)
	grab_focus()

func _process(delta):
	pass

func llm_chunk(chunk):
	if (chunk != "<|im_start|>" and chunk != "<|im_end|>"):
		get_node("../GameMasterOutput").text += chunk
	if "Not very polite" in get_node("../GameMasterOutput").text :
		get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")
	if "Ok, you are forgiven." in get_node("../Output").text :
		get_tree().change_scene_to_file("res://scenes/" + Global.SCENE + "/" + Global.SCENE + ".tscn")

# Override _gui_input instead of _input for GUI elements like TextEdit.
func _gui_input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed and key_event.keycode == KEY_ENTER:
			var user_message = text # Get the text from the TextEdit
			var system_message = Global.INSTRUCTIONS
			clear()
			get_node("../GameMasterOutput").text = ""
			LlmServer.send_text(system_message, user_message)
			get_viewport().set_input_as_handled()
