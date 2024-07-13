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
	if Global.COMMAND.find("001") != -1:
		print("Pig time!")
		Global.COMMAND = ""
		#NavigationManager.go_to_scene('xx_pig')
		get_tree().change_scene_to_file("res://scenes/xx_pig/xx_pig.tscn")
	elif Global.COMMAND.find("002") != -1:
		print("Out of pig!")
		Global.COMMAND = ""
		# NavigationManager.go_to_scene(Global.SCENE)
		get_tree().change_scene_to_file("res://scenes/" + Global.SCENE + "/" + Global.SCENE + ".tscn")
	elif Global.COMMAND.find("003") != -1:
		print("Climbs!")
		Global.COMMAND = ""
		# NavigationManager.go_to_scene('02_nest')
		get_tree().change_scene_to_file("res://scenes/02_nest/02_nest.tscn")
	elif Global.COMMAND.find("004") != -1:
		print("Picks up the knife!")
		# Get all available nodes and their paths
		var root = get_tree().get_root()
		var nodes = get_all_nodes(root)
		print("Available nodes and their paths:")
		for node_path in nodes:
			print(node_path)
		var sprite = get_node("/root/02_tree/Knife")  # Adjust this path to match your scene structure
		var target_position = Vector2(1825, 249)  # Adjust this to your desired target position
		var duration = 1.0  # Duration of the transition in seconds

		var tween = create_tween()
		if sprite:
			tween.tween_property(sprite, "position", target_position, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			tween.play()
		else:
			print("Error: Sprite is null. Unable to tween.")

		# Wait for the tween to finish before continuing
		await tween.finished
		Global.COMMAND = ""
	elif Global.COMMAND.find("005") != -1:
		print("Down the tree!")
		Global.COMMAND = ""
		# NavigationManager.go_to_scene('02_tree')
		get_tree().change_scene_to_file("res://scenes/02_tree/02_tree.tscn")
	elif (Global.COMMAND == "NORTH"
		or Global.COMMAND == "WEST"
		or Global.COMMAND == "SOUTH"
		or Global.COMMAND == "EAST"):
		print("Navigates")
		var direction = Global.COMMAND.to_lower()
		Global.COMMAND = ""
		if (Global.COMPASS[direction] != null):
			# NavigationManager.go_to_scene(Global.COMPASS[direction])
			get_tree().change_scene_to_file("res://scenes/" + Global.COMPASS[direction] + "/" + Global.COMPASS[direction] + ".tscn")
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
