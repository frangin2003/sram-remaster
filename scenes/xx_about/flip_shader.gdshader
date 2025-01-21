shader_type canvas_item;

void fragment() {
    vec2 uv = vec2(1.0 - UV.x, UV.y);
    COLOR = texture(TEXTURE, uv);
}