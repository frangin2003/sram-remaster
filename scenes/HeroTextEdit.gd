extends TextEdit

signal speak_seconds(speaker, seconds)

var gameMasterOutput
var BEGIN_OF_TEXT_TAG = "<|begin_of_text|>"
var END_OF_TEXT_TAG = "<|end_of_text|>"
var ACTION_TAG = "<|action|>"
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
		and !chunk.begins_with(ACTION_TAG)):
		gameMasterOutput.text += chunk
	if (chunk.begins_with(ACTION_TAG)):
		LlmServer.ACTION = chunk.substr(ACTION_TAG.length(), chunk.length() - ACTION_TAG.length())
	if LlmServer.ACTION == "DEATH":
		print("Death!")
		LlmServer.ACTION = ""
		Global.set_scene("xx_death")
	elif LlmServer.ACTION == "PIG":
		print("Pig time!")
		LlmServer.ACTION = ""
		Global.set_scene("xx_pig")
		# get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")

	else:
		var navigation = LlmServer.ACTION.strip_edges().to_upper()
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
			LlmServer.ACTION = ""
			if (next_scene != null):
				print("Navigate to " + next_scene)
				Global.set_scene(next_scene)
		elif ActionHandler.CURRENT_HANDLER != null:
			LlmServer.ACTION = LlmServer.ACTION.strip_edges().replace("[^0-9]", "")
			if LlmServer.ACTION != null and !LlmServer.ACTION.is_empty():
				ActionHandler.execute_action(LlmServer.ACTION)

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
