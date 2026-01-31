shader_type canvas_item;

uniform float opacity;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    vec4 color = texture(screen_texture, UV);
	color.rgb= vec3(0.,0.,0.);
	
    COLOR = vec4(color.rgb, opacity);
}