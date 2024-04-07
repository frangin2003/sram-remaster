extends Node

var llm_inputs = []
var llm_chunks = []
signal llm_chunk(chunk)

var socket = WebSocketPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	socket.connect_to_url("ws://localhost:8765")

func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		var new_output = ''
		while socket.get_available_packet_count():
			var chunk = socket.get_packet().get_string_from_utf8()
			print("Chunk: ", chunk)
			llm_chunks.append(chunk)
			emit_signal("llm_chunk", chunk)
				
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.

# Override _gui_input instead of _input for GUI elements like TextEdit.
func send_text(system_message, user_message):
	var message_dict = {"user": user_message, "system": system_message}
	llm_inputs.append(message_dict)
	var json_message = JSON.stringify(message_dict)
	socket.send_text(json_message)
