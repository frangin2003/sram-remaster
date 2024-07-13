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

func _process(_delta):
	pass

func get_all_nodes(node):
	var nodes = []
	nodes.append(node.get_path())
	_get_all_nodes_recursive(node, nodes)
	return nodes

func _get_all_nodes_recursive(node, nodes):
	for child in node.get_children():
		nodes.append(child.get_path())
		_get_all_nodes_recursive(child, nodes)

func llm_chunk(chunk):
	LlmServer.OUTPUT += chunk
	if (chunk == END_OF_TEXT_TAG):
		get_node("../RecordVoiceButton").visible = true
		Memory.add_to_memory(LlmServer.create_assistant_message(LlmServer.OUTPUT))
	if (chunk != BEGIN_OF_TEXT_TAG
		and chunk != END_OF_TEXT_TAG
		and !chunk.begins_with(COMMAND_TAG)):
		gameMasterOutput.text += chunk
	if (chunk.begins_with(COMMAND_TAG)):
		LlmServer.COMMAND = chunk.substr(COMMAND_TAG.length(), chunk.length() - COMMAND_TAG.length())
	if LlmServer.COMMAND.find("001") != -1:
		print("Pig time!")
		LlmServer.COMMAND = ""
		#NavigationManager.go_to_scene('xx_pig')
		get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")
	elif (LlmServer.COMMAND == "NORTH"
		or LlmServer.COMMAND == "WEST"
		or LlmServer.COMMAND == "SOUTH"
		or LlmServer.COMMAND == "EAST"):
		print("Navigates")
		var direction = LlmServer.COMMAND.to_lower()
		LlmServer.COMMAND = ""
		if (Global.COMPASS[direction] != null):
			# NavigationManager.go_to_scene(Global.COMPASS[direction])
			get_tree().change_scene_to_file("res://scenes/" + Global.COMPASS[direction] + "/" + Global.COMPASS[direction] + ".tscn")
	elif CommandHandler.CURRENT_HANDLER != null:
		CommandHandler.execute_command(LlmServer.COMMAND)

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
