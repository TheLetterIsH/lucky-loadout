shader_type canvas_item;

const int MAX_BACKGROUND_COLORS = 2;
uniform vec4 background_colors[MAX_BACKGROUND_COLORS] : source_color;
uniform vec4 shadow_color : source_color;
uniform vec2 offset_in_pixels;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

bool is_background_color(vec4 color) {
    for (int i = 0; i < MAX_BACKGROUND_COLORS; i++) {
        if (length(color - background_colors[i]) < 0.01) {
            return true;
        }
    }
    return false;
}

void fragment() {
    vec4 current_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);

    if (is_background_color(current_color)) {
        vec2 offset = offset_in_pixels * SCREEN_PIXEL_SIZE;
        vec4 offset_color = textureLod(SCREEN_TEXTURE, SCREEN_UV - offset, 0.0);

        if (!is_background_color(offset_color)) {
            current_color = shadow_color;
        }
    }

    COLOR = current_color;
}
