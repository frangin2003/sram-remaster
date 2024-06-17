shader_type canvas_item;

uniform float pulse_speed = 0.03;
uniform float pulse_strength = 0.3;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    
    // Calculate a slowly oscillating value between -1 and 1 using sine
    float pulse = (sin(TIME * pulse_speed) * pulse_strength) / 2.0 - 0.1;
    
    // Add the pulse value to the original color to make it subtly brighter or darker
    vec4 pulsed_color = original_color + vec4(pulse, pulse, pulse, 0.0);
    
    COLOR = pulsed_color;
}