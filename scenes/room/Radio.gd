extends Sprite2D

func _ready():
	# Create the blur effect
	var blur = FastNoiseLite.new()
	
	# Create a new ShaderMaterial
	var material = ShaderMaterial.new()
	material.shader = preload("res://scenes/room/blur.gdshader")
	
	# Apply material to sprite
	self.material = material
