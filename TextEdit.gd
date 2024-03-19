extends TextEdit

var socket = WebSocketPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure the TextEdit can focus to receive key inputs.
	set_focus_mode(FOCUS_ALL)
	socket.connect_to_url("ws://localhost:8765")

func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		var isFirstOutput = true  # Flag to check if it's the first output
		while socket.get_available_packet_count():
			var output = socket.get_packet().get_string_from_utf8()
			# If it's the first output, strip leading whitespaces
			if isFirstOutput and output:
				get_node("../Output").text = ""
				output = output.strip_edges(true, false)
				isFirstOutput = false  # Update the flag so this only happens once
			print("Packet: ", output)
			get_node("../Output").text += output
			if "PIG TIME" in output :
				get_tree().change_scene_to_file("res://tableau_xxx_pig.tscn")
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.

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
			var message_dict = {"user": user_message, "system": system_message}
			var json_message = JSON.stringify(message_dict)
			print("Sending: ", json_message)
			socket.send_text(json_message)
			clear()
			get_viewport().set_input_as_handled()
