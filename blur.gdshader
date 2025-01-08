shader_type canvas_item;

uniform float blur_amount: hint_range(0.0, 5.0) = 2.0;

void fragment() {
    vec4 blurred = vec4(0.0);
    
    // Sample multiple times around the pixel
    for(float x = -blur_amount; x <= blur_amount; x += 1.0) {
        for(float y = -blur_amount; y <= blur_amount; y += 1.0) {
            vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
            blurred += texture(TEXTURE, UV + offset);
        }
    }
    
    // Average the samples
    float samples = (blur_amount * 2.0 + 1.0) * (blur_amount * 2.0 + 1.0);
    COLOR = blurred / samples;
} 