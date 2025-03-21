shader_type canvas_item;

uniform float outline_width = 1.0 ;
uniform vec4 outline_coloer:source_color = vec4 (0.0,2,0.829,1);

void fragment() {
	vec2 uv = UV;

	vec2 uv_up = uv + vec2(0,TEXTURE_PIXEL_SIZE.y) * outline_width;
	vec2 uv_down = uv + vec2(0,-TEXTURE_PIXEL_SIZE.y) * outline_width;
	vec2 uv_left = uv + vec2(TEXTURE_PIXEL_SIZE.x,0) * outline_width;
	vec2 uv_right = uv + vec2(-TEXTURE_PIXEL_SIZE.x,0) * outline_width;
	vec2 uv_up_right = uv + vec2(TEXTURE_PIXEL_SIZE.x,TEXTURE_PIXEL_SIZE.y) * outline_width;
	vec2 uv_up_left = uv + vec2(TEXTURE_PIXEL_SIZE.x,-TEXTURE_PIXEL_SIZE.y) * outline_width;
	vec2 uv_down_right = uv + vec2(-TEXTURE_PIXEL_SIZE.x,TEXTURE_PIXEL_SIZE.y) * outline_width;
	vec2 uv_down_left = uv + vec2(-TEXTURE_PIXEL_SIZE.x,-TEXTURE_PIXEL_SIZE.y) * outline_width;

	vec4 color_up = texture(TEXTURE,uv_up);
	vec4 color_down = texture(TEXTURE,uv_down);
	vec4 color_left = texture(TEXTURE,uv_left);
	vec4 color_right = texture(TEXTURE,uv_right);
	vec4 color_up_right = texture(TEXTURE,uv_up_right);
	vec4 color_up_left = texture(TEXTURE,uv_up_left);
	vec4 color_down_right = texture(TEXTURE,uv_down_right);
	vec4 color_down_left = texture(TEXTURE,uv_down_left);

	vec4 outline = color_up + color_down + color_left + color_right + color_up_right+color_up_left + color_down_right + color_down_left;

	outline.rgb = outline_coloer.rgb;

	outline.a = min(outline.a,1);

	vec4 original_color = texture(TEXTURE,UV);

	COLOR = mix(outline,original_color,original_color.a);
}
