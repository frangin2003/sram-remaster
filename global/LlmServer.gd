extends Node

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
			emit_signal("llm_chunk", chunk)
				
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.

func create_message(role, prompt, image_url=null, with_speech: bool=false):
	var message_dict = {}
	if (not with_speech or image_url == null):
		message_dict = {"role": role, "content": prompt}
	else:
		var content_array = []
		
		if (prompt != null):
			content_array.append({
				"type": "text",
				"text": prompt
			})
		
		if (with_speech):
			content_array.append({
				"type": "speech_url",
				"speech_url": {"url": Global.RECORDED_AUDIO_URL}
			})
		
		if (image_url != null):
			content_array.append({
				"type": "image_url",
				"image_url": {"url": image_url}
			})
		
		message_dict = {"role": role, "content": content_array}
	
	Global.add_to_memory(message_dict)
	return message_dict

func create_assistant_message(output):
	create_message("assistant", output)

func send_to_llm_server(system_prompt: String, user_prompt: String, image_url: String, with_speech: bool) -> void:
	if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
		var messages_array = [create_message("system", system_prompt)]
		Global.LLM_INPUT_ARRAY.append(create_message("user", user_prompt, image_url, with_speech))
		messages_array.append_array(Global.LLM_INPUT_ARRAY)
		socket.send_text(JSON.stringify({"messages": messages_array}))
	else:
		print("WebSocket is not connected.")
