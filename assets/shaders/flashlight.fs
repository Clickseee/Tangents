#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;
uniform float radius;
uniform float edge_softness;
uniform float dissolve;
uniform float screen_scale;
uniform vec2 mouse_screen_pos;
uniform float hovering;
uniform float time;
uniform float texture_details;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = screen_coords / resolution;
    vec2 center = vec2(0.5, 0.5);
    vec2 lightUV = mouse_screen_pos / resolution;
    float dist = length(uv - center);
    float scaled_radius = radius * screen_scale;
    float scaled_edge = edge_softness * screen_scale;
    float spotlight = smoothstep(scaled_radius, scaled_radius - scaled_edge, dist);
    float alpha = mix(1.0, spotlight, dissolve);
    float hover_alpha = mix(1.0, 0.0, hovering);
    float time_alpha = sin(time * 2.0) * 0.5 + 0.5;
    float texture_scale = 1.0 / texture_details;
    vec4 tex = Texel(texture, texture_coords * texture_scale);
    vec4 final_color = vec4(tex.rgb * alpha, tex.a);
    return final_color * color * hover_alpha * time_alpha;
}
