shader_type canvas_item;

uniform vec4 key_color = vec4(0.0, 0.0, 0.0, 1.0); // Green color by default
uniform float threshold = 0.1;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float distance = distance(color, key_color);
    if (distance < threshold) {
        COLOR.a = 0.0; // Make the pixel transparent
    } else {
        COLOR = color;
    }
}