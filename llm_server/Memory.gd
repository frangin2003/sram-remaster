extends Node

var LLM_INPUT_ARRAY = []

func add_to_memory(message):
	LLM_INPUT_ARRAY.append(message)

func reset_memory():
	LLM_INPUT_ARRAY = []

func _ready():
	reset_memory()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
