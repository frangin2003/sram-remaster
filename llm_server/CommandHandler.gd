extends Node

var CURRENT_HANDLER = null

func execute_command(command):
    if CURRENT_HANDLER:
        CURRENT_HANDLER.execute_command(command)
        LlmServer.COMMAND = ""
    else:
        print("No command handler set for the current scene")