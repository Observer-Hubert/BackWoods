shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform float min_opacity: hint_range(0.0, 1.0, 0.1) = 0.2;
uniform float max_opacity: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform bool inactive = true;
uniform float frequency: hint_range(2.0, 10.0, 0.1) = 2.0;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	vec2 pixel = UV / TEXTURE_PIXEL_SIZE;
	float odd = clamp((round((pixel.y/frequency)) - floor(pixel.y/frequency)),min_opacity, max_opacity
);
	//float odd = mod(round(pixel.y), frequency);
	COLOR.rgb = color.rgb * odd;
	COLOR.a = 1.0;
}

//void light() {

//}
