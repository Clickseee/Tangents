// Balatro-compatible version of the Shadertoy DVD screensaver shader
#ifdef GL_ES
precision mediump float;
#endif

// Uniforms from Lua
uniform vec2 resolution;
uniform float time;

// Texture coordinate
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Convert to normalized UV based on resolution
    vec2 uv = screen_coords / resolution;
    vec2 p = (uv - 0.5) * vec2(resolution.x / resolution.y, 1.0) * 2.0;

    vec2 screenSize = vec2(resolution.x / resolution.y, 1.0) * 2.0;
    vec2 dir = normalize(vec2(9.0, 16.0) * screenSize);
    vec2 move = dir * time / 1.5;

    float logoScale = 0.1;
    vec2 logoSize = vec2(2.0, 0.85) * logoScale;
    vec2 size = screenSize - logoSize * 2.0;

    move = move / size + 0.5;
    move = (move - 0.5) * size;

    float d = length(p - move) - 0.2;
    float ring = smoothstep(0.01, 0.0, abs(d));

    // Simulated palette and ripple color
    vec3 baseColor = vec3(0.5 + 0.5 * sin(time + p.xyx * 3.0));
    vec3 dvdColor = mix(vec3(1.0, 1.0, 1.0), baseColor, ring);

    // Apply fake lighting bump
    vec2 e = vec2(1.0) / resolution.y;
    float fx = (length(p + vec2(e.x, 0.0) - move) - d);
    float fy = (length(p + vec2(0.0, e.y) - move) - d);
    vec3 norm = normalize(vec3(fx, fy, e.x));
    vec3 lightDir = normalize(vec3(1.0, 2.0, 2.0));
    float diff = max(dot(norm, lightDir), 0.0);

    vec3 colorOut = dvdColor * diff;

    // Mix with card texture
    vec4 tex = Texel(texture, texture_coords);
    vec4 final_color = vec4(colorOut, 1.0);
    return tex * final_color * color;
}
