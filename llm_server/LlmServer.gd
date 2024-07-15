extends Node

signal llm_chunk(chunk)
signal websocket_connected
signal websocket_disconnected

var WEBSOCKET: WebSocketPeer = null
var LLM_SERVER_PORT = null
var connection_timer: Timer
var attempts = 0
const MAX_ATTEMPTS = 60  # 1 minute timeout (60 * 1 second)
var first_connection_established = false

var OUTPUT = ""
var COMMAND = ""

var ConfigManager = preload("res://llm_server/ConfigManager.gd").new()

func _ready():
	LLM_SERVER_PORT = ConfigManager.load_config("Network", "port", LLM_SERVER_PORT)
	print("LlmServer: Config loaded, port: ", LLM_SERVER_PORT)
	start_connection_attempt()

func start_connection_attempt():
	connection_timer = Timer.new()
	connection_timer.connect("timeout", Callable(self, "_on_connection_timer_timeout"))
	connection_timer.set_wait_time(1.0)  # 1 second between attempts
	connection_timer.set_one_shot(false)  # Repeat the timer
	add_child(connection_timer)
	connection_timer.start()

func _on_connection_timer_timeout():
	attempts += 1
	if attempts > MAX_ATTEMPTS:
		print("LlmServer: Connection attempts timed out after 1 minute")
		connection_timer.stop()
		return

	print("LlmServer: Checking if port ", LLM_SERVER_PORT, " is in use")
	if not is_port_in_use(LLM_SERVER_PORT):
		print("LlmServer: Port ", LLM_SERVER_PORT, " is not in use. Server might not be ready.")
		return

	print("LlmServer: Attempting to connect to WebSocket server (Attempt ", attempts, ")")
	WEBSOCKET = WebSocketPeer.new()
	var err = WEBSOCKET.connect_to_url("ws://localhost:" + str(LLM_SERVER_PORT))
	if err != OK:
		print("LlmServer: Failed to initiate WebSocket connection: ", err)
	else:
		print("LlmServer: WebSocket connection initiated, waiting for connection to open...")

func _process(_delta):
	if WEBSOCKET == null:
		return
	
	WEBSOCKET.poll()
	var state = WEBSOCKET.get_ready_state()
	match state:
		WebSocketPeer.STATE_CONNECTING:
			print("LlmServer: Still connecting...")
		WebSocketPeer.STATE_OPEN:
			if connection_timer:
				connection_timer.stop()
				connection_timer.queue_free()
				connection_timer = null
			if not first_connection_established:
				print("LlmServer: WebSocket connection established")
				first_connection_established = true
			emit_signal("websocket_connected")
			while WEBSOCKET.get_available_packet_count():
				var chunk = WEBSOCKET.get_packet().get_string_from_utf8()
				print("LlmServer: Chunk: ", chunk)
				emit_signal("llm_chunk", chunk)
		WebSocketPeer.STATE_CLOSING:
			print("LlmServer: WebSocket is closing...")
		WebSocketPeer.STATE_CLOSED:
			var code = WEBSOCKET.get_close_code()
			var reason = WEBSOCKET.get_close_reason()
			print("LlmServer: WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
			WEBSOCKET = null
			emit_signal("websocket_disconnected")
			if attempts <= MAX_ATTEMPTS:
				print("LlmServer: Retrying connection...")
				start_connection_attempt()

func is_port_in_use(port):
	var output = []
	var exit_code = OS.execute("cmd.exe", ["/c", "netstat -ano | findstr :%d" % port], output, true)
	for line in output:
		print("LlmServer: Port check output: ", line)
	return exit_code == 0 and output.size() > 0 and ("LISTENING" in output[0] or "ESTABLISHED" in output[0])

func send_to_llm_server(system_prompt: String, user_prompt: String, with_speech: bool=false, image_url=null, system_image_url=null) -> void:
	OUTPUT = ""
	COMMAND = ""

	if WEBSOCKET == null:
		print("LlmServer: WebSocket is not initialized.")
		return

	if WEBSOCKET.get_ready_state() == WebSocketPeer.STATE_OPEN:
		var messages_array = [create_message("system", system_prompt, false, system_image_url)]
		if (image_url != null):
			remove_messages_with_images()
		Memory.LLM_INPUT_ARRAY = [create_message("user", user_prompt, with_speech, image_url)]
		messages_array.append_array(Memory.LLM_INPUT_ARRAY)
		WEBSOCKET.send_text(JSON.stringify({"messages": messages_array}))
	else:
		print("LlmServer: WebSocket is not connected.")

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
			"speech_url": {"url": AudioRecording.RECORDED_AUDIO_URL}
		})
	
	if (image_url != null):
		content_array.append({
			"type": "image_url",
			"image_url": {"url": image_url}
		})
	
	return {"role": role, "content": content_array}

func remove_messages_with_images():
	var filtered_array = []
	
	for message in Memory.LLM_INPUT_ARRAY:
		if message.has("role") and message["role"] == "user":
			if message.has("content") and typeof(message["content"]) == TYPE_DICTIONARY:
				if message["content"].has("image_url"):
					continue
		
		filtered_array.append(message)
	
	Memory.LLM_INPUT_ARRAY = filtered_array

func create_assistant_message(output):
	return create_message("assistant", output)
