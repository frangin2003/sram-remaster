extends Node

var CURRENT_HANDLER = null

func execute_action(action):
	if CURRENT_HANDLER:
		print("Action: " + action)
		CURRENT_HANDLER.execute_action(action)
		LlmServer.ACTION = ""
	else:
		print("No action handler set for the current scene")
