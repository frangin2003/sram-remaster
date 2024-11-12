extends CanvasLayer

func _ready():
	# Initialize both shaders to their starting states
	var pixelate_material = $PixelateColorRect.material as ShaderMaterial
	var unpixelate_material = $UnpixelateColorRect.material as ShaderMaterial
	
	pixelate_material.set_shader_parameter("animation_time", 0.0)
	unpixelate_material.set_shader_parameter("animation_time", 1.0)
	
	$PixelateColorRect.hide()
	$UnpixelateColorRect.hide()

func pixelate():
	$PixelateColorRect.show()
	var shader_material = $PixelateColorRect.material as ShaderMaterial
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(shader_material, "shader_parameter/animation_time", 1.0, 0.5)
	await tween.finished

func unpixelate():
	
	$PixelateColorRect.hide()
	var shader_material_pixelate = $PixelateColorRect.material
	shader_material_pixelate.set_shader_parameter("animation_time", 0.0)
	$UnpixelateColorRect.show()
	var shader_material_unpixelate = $UnpixelateColorRect.material as ShaderMaterial
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(shader_material_unpixelate, "shader_parameter/animation_time", 0.0, 0.5)
	await tween.finished
	$UnpixelateColorRect.hide()
	shader_material_unpixelate.set_shader_parameter("animation_time", 1.0)  # Reset shader to initial state
