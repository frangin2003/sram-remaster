extends Node

const CONFIG_FILE_PATH = "res://settings.cfg"

func load_config(section: String, key: String, default_value):
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err == OK:
		return config.get_value(section, key, default_value)
	else:
		print("ConfigManager: Failed to load config file, using default value")
		save_config(key, default_value)
		return default_value

func save_config(key: String, value):
	var config = ConfigFile.new()
	config.load(CONFIG_FILE_PATH)
	config.set_value("Game", key, value)
	config.save(CONFIG_FILE_PATH)
