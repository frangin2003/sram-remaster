extends TextEdit

var gameMasterOutput
var BEGIN_OF_TEXT_TAG = "<|begin_of_text|>"
var END_OF_TEXT_TAG = "<|end_of_text|>"
var COMMAND_TAG = "<|command|>"


# Called when the node enters the scene tree for the first time.
func _ready():
	LlmServer.connect("llm_chunk", llm_chunk)
	gameMasterOutput = get_node("../GameMasterBackground/GameMasterOutput")
	grab_focus()

func _process(delta):
	pass

func llm_chunk(chunk):
	Global.OUTPUT += chunk
	if (chunk == END_OF_TEXT_TAG):
		get_node("../RecordVoiceButton").visible = true
		Global.add_to_memory(LlmServer.create_assistant_message(Global.OUTPUT))
	if (chunk != BEGIN_OF_TEXT_TAG
		and chunk != END_OF_TEXT_TAG
		and !chunk.begins_with(COMMAND_TAG)):
		gameMasterOutput.text += chunk
	if (chunk.begins_with(COMMAND_TAG)):
		Global.COMMAND = chunk.substr(COMMAND_TAG.length(), chunk.length() - COMMAND_TAG.length())
	if Global.COMMAND.to_lower().find("cmd_001") != -1:
		print("Pig time!")
		Global.COMMAND = ""
		
		NavigationManager.go_to_scene('xx_pig')
		#get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")
	if Global.COMMAND.to_upper().find("cmd_002") != -1:
		print("Out of pig!")
		Global.COMMAND = ""
		NavigationManager.go_to_scene(Global.SCENE)
		#get_tree().change_scene_to_file("res://scenes/" + Global.SCENE + "/" + Global.SCENE + ".tscn")

# Override _gui_input instead of _input for GUI elements like TextEdit.
func _gui_input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed and key_event.keycode == KEY_ENTER:
			var user_message = text # Get the text from the TextEdit
			clear()
			gameMasterOutput.text = ""
			LlmServer.send_to_llm_server(Global.SYSTEM, user_message)
			get_viewport().set_input_as_handled()
