extends AudioStreamPlayer

var effect  # See AudioEffect in docs
var recording  # See AudioStreamSample in docs
var stereo := true
var mix_rate := 44100  # This is the default mix rate on recordings
var format := 1  # This equals to the default format: 16 bits
var gameMasterOutput

# Called when the node enters the scene tree for the first time.
func _ready():
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)
	gameMasterOutput = get_node("../GameMasterBackground/GameMasterOutput")

func _on_record_voice_button_audio_recording_started():
	if !effect.is_recording_active():
		effect.set_recording_active(true)

func _on_record_voice_button_audio_recording_stopped():
	if effect.is_recording_active():
		recording = effect.get_recording()
		effect.set_recording_active(false)
		recording.set_mix_rate(mix_rate)
		recording.set_format(format)
		recording.set_stereo(stereo)
				
		Global.RECORDED_AUDIO = recording.data
		print(Global.RECORDED_AUDIO_URL)
		recording.save_to_wav(Global.RECORDED_AUDIO_URL)
		print("Audio saved to: ", Global.RECORDED_AUDIO_URL)

		get_node("../RecordVoiceButton").visible = true
		gameMasterOutput.text = ""
		LlmServer.send_to_llm_server(Global.SYSTEM, "", true)
