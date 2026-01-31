shader_type canvas_item;
render_mode blend_mix; 

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noise_texture : repeat_enable;

void fragment() {
    vec4 noise_color = texture(noise_texture, UV + (TIME/10.0));
    vec4 color = texture(screen_texture, UV + (noise_color.b/20.0));
	color.rg=vec2(0,0);
    COLOR = color; 
}
