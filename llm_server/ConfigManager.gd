extends Node

var CONFIG_DIR = OS.get_user_data_dir() + "/sram-remaster"
var CONFIG_FILE_PATH = CONFIG_DIR + "/game.cfg"

func _ready():
	ensure_config_dir_exists()

func ensure_config_dir_exists():
	if not DirAccess.dir_exists_absolute(CONFIG_DIR):
		DirAccess.make_dir_recursive_absolute(CONFIG_DIR)
	print("Config file path: " + CONFIG_FILE_PATH)

func load_config(section: String, key: String, default_value = null):
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err == OK and config.has_section_key(section, key):
		return config.get_value(section, key)
	else:
		print("ConfigManager: Using default value for %s/%s" % [section, key])
		if default_value != null:
			save_config(key, default_value)
		return default_value

func save_config(key: String, value):
	var config = ConfigFile.new()
	config.load(CONFIG_FILE_PATH)
	config.set_value("Game", key, value)
	config.save(CONFIG_FILE_PATH)
