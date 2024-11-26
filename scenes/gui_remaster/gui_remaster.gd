extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("LlmOn").visible = LlmServer.IS_LLM_ON
