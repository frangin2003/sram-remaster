shader_type canvas_item;

uniform float brightness : hint_range(-1, 1) = 0.0;
uniform float contrast : hint_range(0, 3) = 1.0;
uniform float saturation : hint_range(0, 3) = 1.0;
uniform vec3 tint : source_color = vec3(1.0, 1.0, 1.0);

vec3 rgb2hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	// Apply brightness
	color.rgb += brightness;
	
	// Apply contrast
	color.rgb = (color.rgb - 0.5) * contrast + 0.5;
	
	// Apply saturation
	vec3 hsv = rgb2hsv(color.rgb);
	hsv.y *= saturation;
	color.rgb = hsv2rgb(hsv);
	
	// Apply tint
	color.rgb *= tint;
	
	COLOR = color;
}
