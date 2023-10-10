shader_type canvas_item;

void fragment () {
	COLOR = vec4(1.0, 1.0, 1.0, texture(TEXTURE, UV).a);
}