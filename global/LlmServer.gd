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

func create_message(role, prompt, with_speech: bool=false, image_url=null):
	var content_array = []
	
	if (prompt != null and prompt != ""):
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
	
	return {"role": role, "content": content_array}

func remove_messages_with_images():
	var filtered_array = []
	
	for message in Global.LLM_INPUT_ARRAY:
		if message.has("role") and message["role"] == "user":
			if message.has("content") and typeof(message["content"]) == TYPE_DICTIONARY:
				if message["content"].has("image_url"):
					continue
		
		filtered_array.append(message)
	
	Global.LLM_INPUT_ARRAY = filtered_array

func create_assistant_message(output):
	return create_message("assistant", output)

func send_to_llm_server(system_prompt: String, user_prompt: String, with_speech: bool=false, image_url=null, system_image_url=null) -> void:
	Global.OUTPUT = ""
	Global.COMMAND = ""

	if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
		var messages_array = [create_message("system", system_prompt, false, system_image_url)]
		if (image_url != null):
			remove_messages_with_images()
		#Global.add_to_memory(create_message("user", user_prompt, with_speech, image_url))
		Global.LLM_INPUT_ARRAY = [create_message("user", user_prompt, with_speech, image_url)]
		messages_array.append_array(Global.LLM_INPUT_ARRAY)
		socket.send_text(JSON.stringify({"messages": messages_array}))
	else:
		print("WebSocket is not connected.")
