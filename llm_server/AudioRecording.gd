extends Node

var RECORDED_AUDIO: PackedByteArray
var RECORDED_AUDIO_URL = ProjectSettings.globalize_path("res://") + "recorded_audio.wav"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func resetAudio():
	RECORDED_AUDIO = PackedByteArray()

func _ready():
	resetAudio()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
