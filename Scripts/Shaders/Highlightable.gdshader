shader_type canvas_item;

uniform vec4 highlight_color : source_color = vec4(1.0,1.0,0.0,1.0);
uniform bool active = false;
uniform float highlight_opacity : hint_range(0.0, 1.0, 0.1) = 0.7;

const float image_segments = 2.0;
const float margin = 0.000001;

void fragment() {
	float highlight = 0.0;
	COLOR.rgb += clamp(highlight_color.rgb - ceil(COLOR.a), 0.0, 1.0);
	highlight += texture(TEXTURE, vec2(clamp(UV.x + TEXTURE_PIXEL_SIZE.x, floor(UV.x*image_segments)/image_segments,ceil(UV.x*image_segments)/image_segments) - margin, UV.y)).a;
	highlight += texture(TEXTURE, vec2(clamp(UV.x - TEXTURE_PIXEL_SIZE.x, floor(UV.x*image_segments)/image_segments,ceil(UV.x*image_segments)/image_segments) + margin, UV.y)).a;
	highlight += texture(TEXTURE, vec2(UV.x, clamp(UV.y + TEXTURE_PIXEL_SIZE.y, floor(UV.y*image_segments)/image_segments,ceil(UV.y*image_segments)/image_segments) - margin)).a;
	highlight += texture(TEXTURE, vec2(UV.x, clamp(UV.y - TEXTURE_PIXEL_SIZE.y, floor(UV.y*image_segments)/image_segments,ceil(UV.y*image_segments)/image_segments) + margin)).a;
	highlight = clamp(highlight, 0.0, highlight_opacity);
	highlight += COLOR.a;
	highlight *= float(active) + COLOR.a;
	COLOR.a = clamp(highlight, 0.0, 1.0);
}