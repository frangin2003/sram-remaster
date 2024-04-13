extends RichTextLabel

@export var fade_duration = 1.0  # Duration of each fade cycle in seconds

var tween: Tween

func _ready():
	start_fading()

func start_fading():
	if tween:
		tween.kill()  # Stop any running tween animation
	
	tween = create_tween()
	tween.set_loops()  # Make the tween loop indefinitely
	
	# Fade out
	tween.tween_property(self, "modulate:a", 0.0, fade_duration * 1.5) \
		.set_trans(Tween.TRANS_LINEAR) \
		.set_ease(Tween.EASE_IN_OUT)
	
	# Fade in
	tween.tween_property(self, "modulate:a", 1.0, fade_duration * 1.5) \
		.set_trans(Tween.TRANS_LINEAR) \
		.set_ease(Tween.EASE_IN_OUT)
