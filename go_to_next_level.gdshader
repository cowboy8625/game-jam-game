shader_type canvas_item;

uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float pulse_speed = 2.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    float dist = distance(UV, vec2(0.5));
    float glow = smoothstep(0.5, 0.0, dist);
    
    float pulse = 0.5 + 0.5 * sin(TIME * pulse_speed);
    
    COLOR = tex_color * glow * light_color * pulse;
}
