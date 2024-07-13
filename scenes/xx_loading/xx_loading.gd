extends Node

func _ready():
	print("Loading screen: Waiting for WebSocket connection...")
	LlmServer.connect("websocket_connected", Callable(self, "_on_websocket_connected"))

func _on_websocket_connected():
	print("Loading screen: WebSocket connected, transitioning to title screen")
	transition_to_title_screen()

func transition_to_title_screen():
	print("Loading screen: Transitioning to title screen")
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
