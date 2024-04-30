extends TextEdit

var gameMasterOutput
var BEGIN_OF_TEXT_TAG = "<|begin_of_text|>"
var END_OF_TEXT_TAG = "<|end_of_text|>"
var COMMAND_TAG = "<|command|>"
var output = ""
var command = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	LlmServer.connect("llm_chunk", llm_chunk)
	gameMasterOutput = get_node("../GameMasterColorRect/GameMasterOutput")
	grab_focus()

func _process(delta):
	pass

func llm_chunk(chunk):
	output += chunk
	if (chunk == END_OF_TEXT_TAG):
		get_node("../RecordVoiceButton").visible = true
		LlmServer.create_assistant_message(output)
	if (chunk != BEGIN_OF_TEXT_TAG
		and chunk != END_OF_TEXT_TAG
		and !chunk.begins_with(COMMAND_TAG)):
		gameMasterOutput.text += chunk
	if (chunk.begins_with(COMMAND_TAG)):
		command = chunk.substr(COMMAND_TAG.length(), chunk.length() - COMMAND_TAG.length())
	if command == "PIG_TIME":
		command = ""
		get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")
	if "Ok, you are forgiven." in gameMasterOutput.text :
		get_tree().change_scene_to_file("res://scenes/" + Global.SCENE + "/" + Global.SCENE + ".tscn")

# Override _gui_input instead of _input for GUI elements like TextEdit.
func _gui_input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed and key_event.keycode == KEY_ENTER:
			var user_message = text # Get the text from the TextEdit
			var system_message = Global.SYSTEM
			get_node("../RecordVoiceButton").visible = false
			clear()
			gameMasterOutput.text = ""
			output = ""
			command = ""
			LlmServer.send_system_and_user_prompt(system_message, user_message)
			get_viewport().set_input_as_handled()
			
