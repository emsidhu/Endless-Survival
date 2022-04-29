shader_type canvas_item;

uniform bool is_white = false;


void fragment() {
	vec4 prev_colour = texture(TEXTURE, UV);
	vec4 white_colour = vec4(0.92, 0.92, 0.92, prev_colour.a);

	vec4 new_colour = prev_colour;

	if (is_white) {
		new_colour = white_colour;
	}
	COLOR = new_colour;
}