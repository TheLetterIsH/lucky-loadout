shader_type canvas_item;

uniform vec2 squash_direction = vec2(0.0, 0.0);
uniform float squash_amount = 0.5; // Adjust this value to control the amount of squash
uniform vec4 flash_color : source_color;
uniform float flash_value : hint_range(0.0, 1.0, 0.1) = 0;

void vertex() {
	if (squash_direction != vec2(0.0, 0.0)) {
		// Normalize the deformation direction to ensure consistent behavior
		vec2 norm_dir = normalize(squash_direction);
		
		// Calculate the perpendicular direction to the deformation direction
		vec2 perp_dir = vec2(-norm_dir.y, norm_dir.x);
		
		// Compute the dot products to find the projection of the vertex in both directions
		float dot_parallel = dot(VERTEX.xy, norm_dir);
		float dot_perpendicular = dot(VERTEX.xy, perp_dir);
		
		// Scale factors for the squash
		float scale_parallel = 1.0 - squash_amount * length(squash_direction);
		float scale_perpendicular = 1.0 + squash_amount * length(squash_direction);
		
		// Apply the scale based on the directions
		vec2 new_pos = dot_parallel * norm_dir * scale_parallel + dot_perpendicular * perp_dir * scale_perpendicular;

		VERTEX.xy = new_pos;
	}
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = mix(texture_color, flash_color, flash_value);
	COLOR.a = texture_color.a;
}
