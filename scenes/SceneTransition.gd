extends Node2D

var current_scene: Node
var next_scene: Node
var screenshot: TextureRect

func _ready():
	screenshot = TextureRect.new()
	add_child(screenshot)
	screenshot.hide()

func transition_to_scene(new_scene_path: String, navigation: String):
	# Take screenshot of current scene
	var img = get_viewport().get_texture().get_image()
	var texture = ImageTexture.create_from_image(img)
	screenshot.texture = texture
	screenshot.show()
	
	# Remove current scene
	if current_scene:
		current_scene.queue_free()
	
	# Load next scene
	next_scene = load(new_scene_path).instantiate()
	add_child(next_scene)
	next_scene.position = get_viewport_rect().size * navigation_to_vector2(navigation)
	
	# Start transition
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(screenshot, "position", -get_viewport_rect().size * navigation_to_vector2(navigation), 1.0)
	tween.tween_property(next_scene, "position", Vector2.ZERO, 1.0)
	
	await tween.finished
	
	# Clean up
	screenshot.hide()
	current_scene = next_scene
	next_scene = null

func navigation_to_vector2(navigation: String) -> Vector2:
	match navigation:
		"NORTH": return Vector2.UP
		"EAST": return Vector2.RIGHT
		"SOUTH": return Vector2.DOWN
		"WEST": return Vector2.LEFT
	return Vector2.ZERO
