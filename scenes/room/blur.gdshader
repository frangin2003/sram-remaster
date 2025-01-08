shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 10.0;

void fragment() {
    vec4 color = vec4(0.0);
    float kernel[9] = float[9](
        1.0, 2.0, 1.0,
        2.0, 4.0, 2.0,
        1.0, 2.0, 1.0
    );
    
    for(int i = -1; i <= 1; i++) {
        for(int j = -1; j <= 1; j++) {
            vec2 offset = vec2(float(i), float(j)) * blur_amount * TEXTURE_PIXEL_SIZE;
            color += texture(TEXTURE, UV + offset) * kernel[(i + 1) * 3 + (j + 1)] / 16.0;
        }
    }
    
    COLOR = color;
}