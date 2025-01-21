extends TextureButton

@export var rotation_speed: float = 2.0  # Rotation speed in radians per second
var is_hovering: bool = false
var current_rotation: float = 0.0  # Keep track of total rotation

@onready var small_cog = get_parent().get_node("SmallCog")  # Get sibling node
@onready var settings_container = get_parent().get_node("xx_settings/MarginContainer")

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_button_pressed)  # Connect to the pressed signal
	# Set the pivot offset to the center of the button
	pivot_offset = size / 2
	
	# Set the small cog's center offset for rotation around its own center
	if small_cog:
		# var texture_size = small_cog.texture.get_size()
		small_cog.offset = Vector2.ZERO  # Reset offset so it rotates around its center
		small_cog.centered = true  # This will make it rotate around its center

# Called when the node's size changes
func _on_resized():
	pivot_offset = size / 2

func _process(delta):
	if is_hovering:
		current_rotation += rotation_speed * delta
		# Normalize the rotation to keep it between 0 and 2π (one full rotation)
		current_rotation = fmod(current_rotation, TAU)
		rotation = current_rotation  # Apply the current rotation
		
		# Rotate small cog in opposite direction
		if small_cog:
			small_cog.rotation = -current_rotation

func _on_mouse_entered():
	is_hovering = true
	# No need to reset current_rotation, it will continue from last position

func _on_mouse_exited():
	is_hovering = false
	# current_rotation maintains its value when mouse exits

func _on_button_pressed():
	if settings_container:
		# Toggle visibility
		settings_container.visible = !settings_container.visible
