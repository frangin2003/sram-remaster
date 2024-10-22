extends TextEdit

signal speak_seconds(speaker, seconds)

var gameMasterOutput
var BEGIN_OF_TEXT_TAG = "<|begin_of_text|>"
var END_OF_TEXT_TAG = "<|end_of_text|>"
var COMMAND_TAG = "<|command|>"
var SPEAK_TAG = "<|speak|>"


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
	if (chunk.begins_with(SPEAK_TAG)):
		var speak = chunk.substr(SPEAK_TAG.length(), chunk.length() - SPEAK_TAG.length())
		var parts = speak.split("|")
		var speaker = parts[0]
		var seconds = float(parts[1])
		emit_signal("speak_seconds", speaker, seconds)
		return
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
	if LlmServer.COMMAND.find("000") != -1 and gameMasterOutput.text.find("dead") != -1:
		print("Death!")
		LlmServer.COMMAND = ""
		Global.set_scene("xx_death")
	elif LlmServer.COMMAND.find("001") != -1 and gameMasterOutput.text.find("polite") != -1:
		print("Pig time!")
		LlmServer.COMMAND = ""
		get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")
	else:
		var navigation = LlmServer.COMMAND.strip_edges().to_upper()
		if navigation == "N" or navigation.begins_with("NORTH"):
			navigation = "NORTH"
		elif navigation == "S" or navigation.begins_with("SOUTH"):
			navigation = "SOUTH"
		elif navigation == "E" or navigation.begins_with("EAST"):
			navigation = "EAST"
		elif navigation == "W" or navigation.begins_with("WEST"):
			navigation = "WEST"
		if navigation in ["NORTH", "SOUTH", "EAST", "WEST"]:
			print("Navigates")
			var next_scene = Global.COMPASS[navigation]
			LlmServer.COMMAND = ""
			if (next_scene != null):
				print("Navigate to " + next_scene)
				Global.set_scene(next_scene, navigation)
		elif CommandHandler.CURRENT_HANDLER != null:
			LlmServer.COMMAND = LlmServer.COMMAND.strip_edges().replace("[^0-9]", "")
			CommandHandler.execute_command(LlmServer.COMMAND)

# Override _gui_input instead of _input for GUI elements like TextEdit.
func _gui_input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed and key_event.keycode == KEY_ENTER:
			var user_message = text # Get the text from the TextEdit
			clear()
			gameMasterOutput.text = ""
			var system_message = Global.get_system_instructions()
			LlmServer.send_to_llm_server(system_message, user_message)
			get_viewport().set_input_as_handled()
