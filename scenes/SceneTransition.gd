extends Node2D

var current_scene: Node

func _ready():
	pass

func transition_to_scene(new_scene_path: String, navigation: String):
	# Remove the current scene if it exists
	if current_scene == null:
		current_scene = get_tree().current_scene
	current_scene.queue_free()

	# Load next scene but don't switch yet
	var packed_scene = load(new_scene_path)
	var next_scene = packed_scene.instantiate()
	get_tree().root.add_child(next_scene)
	
	# Position the new scene off-screen based on navigation direction
	var viewport_size = get_viewport_rect().size
	var offset = navigation_to_vector2(navigation)
	if next_scene is Node2D:
		next_scene.position = viewport_size * offset
	
	# Start transition
	var tween = create_tween()
	tween.set_parallel(true)
	
	# Move new scene to center if it's a Node2D
	if next_scene is Node2D:
		tween.tween_property(next_scene, "position", Vector2.ZERO, 1.0)
	
	await tween.finished

	current_scene = next_scene


func navigation_to_vector2(navigation: String) -> Vector2:
	match navigation:
		"NORTH": return Vector2.UP
		"EAST": return Vector2.RIGHT
		"SOUTH": return Vector2.DOWN
		"WEST": return Vector2.LEFT
	return Vector2.ZERO
