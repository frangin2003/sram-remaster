shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 1000.0) = 1.0;
uniform float animation_time : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    float min_dimension = min(viewport_size.x, viewport_size.y);
    
    // Start with maximum pixelation and reduce to normal
    float reverse_time = animation_time;  // No need to reverse since we start at 1.0
    float animated_size = pixel_size * pow(min_dimension, reverse_time);
    float actual_pixel_size = max(animated_size, 1.0);
    
    vec2 pixels = viewport_size / actual_pixel_size;
    vec2 block_size = viewport_size / pixels;
    vec2 block_pos = floor(FRAGCOORD.xy / block_size);
    vec2 block_center = (block_pos * block_size + block_size * 0.5) / viewport_size;
    
    COLOR = texture(SCREEN_TEXTURE, block_center);
}