shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 1000.0) = 1.0;
uniform float animation_time : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Get viewport size
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    float min_dimension = min(viewport_size.x, viewport_size.y);
    
    // Calculate animated pixel size (exponential growth for better visual effect)
    float animated_size = pixel_size * pow(min_dimension, animation_time);
    float actual_pixel_size = max(animated_size, 1.0);
    
    // Use the same size for both dimensions to create square pixels
    vec2 pixels = viewport_size / actual_pixel_size;
    vec2 block_size = viewport_size / pixels;
    vec2 block_pos = floor(FRAGCOORD.xy / block_size);
    vec2 block_center = (block_pos * block_size + block_size * 0.5) / viewport_size;
    
    COLOR = texture(SCREEN_TEXTURE, block_center);
}