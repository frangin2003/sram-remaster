extends Node

var llm_inputs = []
var llm_chunks = []
signal llm_chunk(chunk)

var socket = WebSocketPeer.new()

func _ready():
	socket.connect_to_url("ws://localhost:8765")

func _process(_delta):
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
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

func get_json_text(system_message, user_message, audio_file_path = ""):
	var message_dict = {"system": system_message, "user": user_message, "audio_file_path": audio_file_path}
	llm_inputs.append(message_dict)
	return JSON.stringify(message_dict)

# Override _gui_input instead of _input for GUI elements like TextEdit.
#func send_text(system_message, user_message):
	#socket.send_text(get_json_text(system_message, user_message))

# Not working for the moment, using file on disk
func send_audio(system_message, user_message, audio_file_path):
	socket.send_text(get_json_text(system_message, user_message, audio_file_path))
#func send_audio(system_message, user_message, audio_bytes):
	#send_text(system_message, "")
	#data_socket.send(audio_bytes)

func send_text(content: Dictionary) -> void:
	if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
		socket.send_text(JSON.stringify(content))
	else:
		print("WebSocket is not connected.")

# Convert ArrayBytes to Base64
func bytearray_to_base64(bytearray: PackedByteArray) -> String:
	return Marshalls.utf8_to_base64(bytearray.get_string_from_utf8())

# Different use cases for sending messages
func send_system_and_user_prompt(system_prompt: String, user_prompt: String) -> void:
	var message = {
		"messages": [
			{"role": "system", "content": system_prompt},
			{"role": "user", "content": [{"type": "text", "text": user_prompt}]}
		]
	}
	send_text(message)

func send_system_and_voice_prompt(system_prompt: String, voice_data: PackedByteArray) -> void:
	var base64_voice = bytearray_to_base64(voice_data)
	var message = {
		"messages": [
			{"role": "system", "content": system_prompt},
			{"role": "user", "content": [{"type": "voice", "voice": {"data": base64_voice}}]}
		]
	}
	send_text(message)

func send_system_and_images_and_user_prompt(system_prompt: String, user_prompt: String, image_data_array: Array) -> void:
	var image_content = []
	for data in image_data_array:
		var base64_image = bytearray_to_base64(data)
		image_content.append({"type": "image", "image": {"data": base64_image}})
	var message = {
		"messages": [
			{"role": "system", "content": system_prompt},
			{"role": "user", "content": [{"type": "text", "text": user_prompt}] + image_content}
		]
	}
	send_text(message)

func send_system_and_images_and_voice_prompt(system_prompt: String, voice_data: PackedByteArray, image_data_array: Array) -> void:
	var base64_voice = bytearray_to_base64(voice_data)
	var image_content = []
	for data in image_data_array:
		var base64_image = bytearray_to_base64(data)
		image_content.append({"type": "image", "image": {"data": base64_image}})
	var message = {
		"messages": [
			{"role": "system", "content": system_prompt},
			{"role": "user", "content": [{"type": "voice", "voice": {"data": base64_voice}}] + image_content}
		]
	}
	send_text(message)
