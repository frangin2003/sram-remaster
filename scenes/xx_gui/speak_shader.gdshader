shader_type canvas_item;

uniform vec4 rect_area = vec4(0.3, 0.3, 0.7, 0.7); // x1, y1, x2, y2 in UV coordinates
uniform float edge_softness : hint_range(0.0, 0.2) = 0.1;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    // Calculate distance from rectangle edges
    vec2 rect_size = rect_area.zw - rect_area.xy;
    vec2 center = rect_area.xy + rect_size * 0.5;
    vec2 half_size = rect_size * 0.5;
    vec2 local_uv = (UV - center) / half_size;
    
    // Calculate distance from edges
    vec2 dist = abs(local_uv);
    float max_dist = max(dist.x, dist.y);
    
    // Create soft edges
    float alpha = 1.0 - smoothstep(1.0 - edge_softness, 1.0, max_dist);
    
    COLOR = vec4(color.rgb, color.a * alpha);
}