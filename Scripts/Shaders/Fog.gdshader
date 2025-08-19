shader_type canvas_item;

uniform sampler2D noise_texture;
uniform sampler2D screen_texture: hint_screen_texture;
uniform float fog_slowness: hint_range(0.0, 25.0, 0.1);
uniform float min_fog_mod: hint_range(0.0, 1.0, 0.01);
uniform float max_fog_mod: hint_range(0.0, 1.0, 0.01);
uniform vec3 fog_color: source_color;

varying vec2 world_position;

render_mode world_vertex_coords;

void vertex() {
	world_position = VERTEX * TEXTURE_PIXEL_SIZE;
}

void fragment() {
	vec4 color = texture(screen_texture, UV);
	vec2 pixel = floor(UV * vec2(480,360))/vec2(480,360);
	color.rgb += fog_color.rgb;
	color *= clamp(texture(noise_texture, pixel + TIME/fog_slowness + world_position - floor(pixel + TIME/fog_slowness + world_position)), min_fog_mod, max_fog_mod);
	COLOR = color;
}
