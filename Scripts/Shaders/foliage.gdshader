shader_type canvas_item;

uniform sampler2D foliage;
uniform float foliageSize;
uniform float slowness;
uniform sampler2D noise_texture;

void fragment() {
	vec2 foliage_pixel_size = vec2(1.0, 1.0);
	vec2 specialUV = mod(vec2(UV.x + sin(TIME/slowness), UV.y - (TIME/slowness)) / foliage_pixel_size,1.0);
	COLOR.rgb -= texture(foliage, specialUV).a;
}