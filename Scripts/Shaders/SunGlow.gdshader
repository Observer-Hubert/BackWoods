shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform vec3 tint_color: source_color;

void fragment() {
	COLOR.rgb = texture(screen_texture, SCREEN_UV).rgb * tint_color;
	COLOR.a = 1.0;
}