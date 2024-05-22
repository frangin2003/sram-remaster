extends Node
var COMPASS = {
	"north": true,
	"east": true,
	"south": true,
	"west": true
}

var INVENTORY = {
	"knife": false,
	"cane": false,
	"water_bottle": false,
	"water": false,
	"snake_skin": false,
	"potion": false,
	"key": false,
	"flute": false,
	"bow": false,
	"arrow": false,
	"lilipad": false,
	"money": false,
	"lives": 0,
	"turtle_eggs": false,
	"werewolf_ear": false,
	"boar_fur": false,
	"leave": false,
	"shovel": false,
	"centaur_hoof": false,
}
# Last scene, defaulted at Menhir
var SCENE = "01_menhir"

#---------------------

var OUTPUT = ""
var COMMAND = ""

var RECORDED_AUDIO: PackedByteArray
var SCREENSHOT: PackedByteArray

var LLM_INPUT_ARRAY = []
var RECORDED_AUDIO_URL = ProjectSettings.globalize_path("res://") + "recorded_audio.wav"
var SCREENSHOT_URL = null
var SYSTEM = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func resetAudioAndScreenshot():
	RECORDED_AUDIO = PackedByteArray()
	SCREENSHOT = PackedByteArray()
	#RECORDED_AUDIO_URL = null
	SCREENSHOT_URL = null

func add_to_memory(message):
	LLM_INPUT_ARRAY.append(message)

func reset_memory():
	LLM_INPUT_ARRAY = []

func check_and_send_to_llm():
	if RECORDED_AUDIO != null and SCREENSHOT != null:
		print("Audio recording and screenshot are ready!")
		LlmServer.send_system_and_one_image_and_voice_prompt(SYSTEM, RECORDED_AUDIO, SCREENSHOT)

func check_and_send_to_llm_urls():
	print("Audio recording and screenshot are ready!")
	LlmServer.send_to_llm_server(SYSTEM, "Look closely at the red token position on the world map and determine which country it is close too.", true)
# Called when the node enters the scene tree for the first time.
func _ready():
	resetAudioAndScreenshot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
