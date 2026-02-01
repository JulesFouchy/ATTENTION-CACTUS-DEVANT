shader_type canvas_item;
render_mode blend_mix;

// --- Paramètres communs ---
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise_texture : hint_screen_texture, repeat_enable;

// --- Activation des effets ---
uniform bool vhs_enabled = false;
uniform bool water_enabled = false;
uniform bool pixelate_enabled = false;
uniform bool negative_enabled = false;
uniform bool edge_enabled = false;
uniform bool radial_aberration_enabled = false;
uniform float global_opacity = 1.;

// Uniforms pour l'aberration chromatique radiale
uniform float radial_aberration_strength : hint_range(0.0, 10.) = 0.02;
uniform float radial_aberration_fade : hint_range(0.0, 10.0) = 0.5;  // Fade-off de l'effet
uniform float radial_aberration_blur : hint_range(0.0, 1) = 0.01;  // Intensité du blur


// Uniforms pour l'effet Edge
uniform float edge_threshold : hint_range(0.0, 0.5) = 0.1;  // Seuil de détection des contours
uniform vec3 edge_color : source_color = vec3(1.0, 1.0, 1.0);  // Couleur des contours (blanc par défaut)
uniform float edge_intensity : hint_range(0.0, 1.0) = 1.0;  // Intensité des contours

//Paramètres Pixelate
uniform float pixel_size = 100.0;

// --- Paramètres VHS ---
uniform float scanlines_opacity : hint_range(0.0, 1.0) = 0.4;
uniform float scanlines_width : hint_range(0.0, 0.5) = 0.25;
uniform float grille_opacity : hint_range(0.0, 1.0) = 0.3;
uniform float roll_speed = 8.0;
uniform float roll_size : hint_range(0.0, 100.0) = 15.0;
uniform float distort_intensity : hint_range(0.0, 0.2) = 0.05;
uniform float aberration : hint_range(-1.0, 1.0) = 0.03;
uniform float noise_opacity : hint_range(0.0, 1.0) = 0.4;
uniform float noise_speed = 5.0;
uniform float vignette_intensity = 0.4;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.5;
uniform vec2 resolution = vec2(640.0, 480.0);

// --- Paramètres Eau ---
uniform float water_distortion : hint_range(0.0, 0.1) = 0.02;
uniform float water_speed : hint_range(0.0, 10.0) = 2.0;
uniform vec3 water_color = vec3(0.0, 0.3, 0.7); // Teinte bleue pour l'eau

// --- Fonctions utilitaires (à garder telles quelles) ---
vec2 random(vec2 uv) {
    uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);
    vec2 blur = smoothstep(0.0, 1.0, uv_fract);
    return mix(
        mix(
            dot(random(uv_index + vec2(0.0, 0.0)), uv_fract - vec2(0.0, 0.0)),
            dot(random(uv_index + vec2(1.0, 0.0)), uv_fract - vec2(1.0, 0.0)),
            blur.x
        ),
        mix(
            dot(random(uv_index + vec2(0.0, 1.0)), uv_fract - vec2(0.0, 1.0)),
            dot(random(uv_index + vec2(1.0, 1.0)), uv_fract - vec2(1.0, 1.0)),
            blur.x
        ),
        blur.y
    ) * 0.5 + 0.5;
}

float border(vec2 uv) {
    float radius = 0.08;
    vec2 abs_uv = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius;
    float dist = length(max(vec2(0.0), abs_uv)) / radius;
    return clamp(1.0 - smoothstep(0.96, 1.0, dist), 0.0, 1.0);
}

float vignette(vec2 uv) {
    uv *= 1.0 - uv.xy;
    float vig = uv.x * uv.y * 15.0;
    return pow(vig, vignette_intensity * vignette_opacity);
}

// --- Effet Eau ---
vec2 water_distort(vec2 uv) {
    if (!water_enabled) return uv;
    vec4 noise_color = texture(noise_texture, uv * 0.5 + TIME * water_speed);
    return uv + (noise_color.rg - 0.5) * water_distortion;
}

// --- Effet VHS ---
vec4 apply_vhs(vec4 color, vec2 uv) {

    // Scanlines
    float scan = smoothstep(scanlines_width, scanlines_width + 0.5, abs(sin(uv.y * (resolution.y * 3.14159265))));
    color.rgb = mix(color.rgb, color.rgb * scan, scanlines_opacity);

    // Grille CRT
    float gr = smoothstep(0.85, 0.95, abs(sin(uv.x * (resolution.x * 3.14159265))));
    float gg = smoothstep(0.85, 0.95, abs(sin(1.05 + uv.x * (resolution.x * 3.14159265))));
    float gb = smoothstep(0.85, 0.95, abs(sin(2.1 + uv.x * (resolution.x * 3.14159265))));
    color.r = mix(color.r, color.r * gr, grille_opacity);
    color.g = mix(color.g, color.g * gg, grille_opacity);
    color.b = mix(color.b, color.b * gb, grille_opacity);

    // Roll effect
    float roll_line = smoothstep(0.3, 0.9, sin(uv.y * roll_size - (TIME * roll_speed)));
    roll_line *= roll_line * smoothstep(0.3, 0.9, sin(uv.y * roll_size * 1.5 - (TIME * roll_speed * 1.5)));
    vec2 roll_uv = vec2(roll_line * distort_intensity, 0.0);

    // Aberration chromatique
    color.r = texture(screen_texture, uv + roll_uv * 0.8 + vec2(aberration, 0.0) * 0.1).r;
    color.g = texture(screen_texture, uv + roll_uv * 1.2 - vec2(aberration, 0.0) * 0.1).g;
    color.b = texture(screen_texture, uv + roll_uv).b;

    // Noise
    float n = noise(uv * vec2(2.0, 200.0) + vec2(10.0, TIME * noise_speed));
    float nl = n * roll_line * clamp(random((ceil(uv * resolution) / resolution)).x + 0.8, 0.0, 1.0);
    color.rgb = mix(color.rgb, color.rgb + nl, noise_opacity);

    // Vignette
    color.rgb *= border(uv);
    color.rgb *= vignette(uv);

    return color;
}

// --- Effet Opacité ---
vec4 apply_opacity(vec4 color) {
	color.rgb = mix(color.rgb, vec3(0.,0.,0.),global_opacity);
    return color;
}
// ---- picelate

vec2 pixelate(vec2 uv) {
    // Calcule le ratio d'aspect
    float aspect_ratio = resolution.x / resolution.y;

    // Ajuste la taille des pixels en fonction du ratio
    vec2 adjusted_pixel_size = (pixel_size * (5. * sin(30.*TIME))) * vec2(aspect_ratio, 1.0);

    // Calcule les coordonnées pixelisées
    vec2 pixel_uv = floor(uv * adjusted_pixel_size) / adjusted_pixel_size;

    // Décalage pour centrer les pixels
    pixel_uv += vec2(0.5 / adjusted_pixel_size.x, 0.5 / adjusted_pixel_size.y);

    // Applique la pixelisation
    return pixel_uv;
}

vec4 apply_edge(vec4 color, vec2 uv) {
    if (!edge_enabled) return color;

    float dx = 1.0 / resolution.x;
    float dy = 1.0 / resolution.y;

    vec3 center = texture(screen_texture, uv).rgb;
    vec3 right = texture(screen_texture, uv + vec2(dx, 0.0)).rgb;
    vec3 left = texture(screen_texture, uv + vec2(-dx, 0.0)).rgb;
    vec3 top = texture(screen_texture, uv + vec2(0.0, dy)).rgb;
    vec3 bottom = texture(screen_texture, uv + vec2(0.0, -dy)).rgb;

    // Calcule la différence de luminosité
    float edge_x = length(right - left);
    float edge_y = length(top - bottom);
    float edge = max(edge_x, edge_y);

    // Applique le seuil et l'intensité
    float edge_factor = smoothstep(edge_threshold, edge_threshold + 0.1, edge);
    vec3 edge_final = mix(center, edge_color, edge_factor * edge_intensity);

    return vec4(edge_final, color.a);
}


vec4 apply_negative(vec4 color) {
    return vec4(1.0 - color.r, 1.0 - color.g, 1.0 - color.b, color.a);
}

vec4 apply_radial_chromatic_aberration(vec4 color, vec2 uv) {
    if (!radial_aberration_enabled) return color;

    // Calcule la distance depuis le centre
    vec2 center_uv = uv - vec2(0.5);
    float dist = length(center_uv) * 2.0;  // Normalise entre 0 et 1

    // Fade-off : Réduit l'effet vers les bords
    float fade_factor = 1.0 - dist;
    fade_factor = smoothstep(radial_aberration_fade, 0.0, fade_factor);

    // Décale les canaux RGB avec un effet radial
    vec2 offset_r = center_uv * radial_aberration_strength * dist * fade_factor * 0.5;
    vec2 offset_g = center_uv * radial_aberration_strength * dist * fade_factor * 0.3;
    vec2 offset_b = center_uv * radial_aberration_strength * dist * fade_factor * 0.0;

    // Applique un léger blur pour adoucir les transitions
    color.r = texture(screen_texture, uv + offset_r).r;
    color.g = texture(screen_texture, uv + offset_g).g;
    color.b = texture(screen_texture, uv + offset_b).b;

    // Mélange avec la couleur originale pour adoucir l'effet
    float blur_amount = radial_aberration_blur * dist;
    color.r = mix(color.r, texture(screen_texture, uv - offset_r * 0.5).r, blur_amount);
    color.g = mix(color.g, texture(screen_texture, uv - offset_g * 0.5).g, blur_amount);
    color.b = mix(color.b, texture(screen_texture, uv - offset_b * 0.5).b, blur_amount);

    return color;
}


// --- Fragment Shader ---
void fragment() {
    vec2 uv = UV;

	if (pixelate_enabled) {
		uv = pixelate(uv);
	}
	
    // 1. Applique la distorsion d'eau en premier
    if (water_enabled) {
        uv = water_distort(uv);
    }

    // 2. Récupère la couleur de base (avec distorsion si eau activée)
    vec4 color = texture(screen_texture, uv);
	
    if (radial_aberration_enabled) color = apply_radial_chromatic_aberration(color, uv);

    // 6. Applique le négatif (si activé)
	if (negative_enabled)
    	color = apply_negative(color);

    // 7. Applique la détection de contours (si activé)
    if (edge_enabled) color = apply_edge(color, uv);

    // 3. Applique l'effet VHS
	if (vhs_enabled) {
		color = apply_vhs(color, uv);}

    // 4. Applique l'effet Eau (teinte bleue)
    if (water_enabled) {
        color.rgb = mix(color.rgb, water_color, 0.3); // 30% de teinte bleue
        color.rgb = mix(color.rgb, vec3(dot(color.rgb, vec3(0.3))), 0.2);
    }

    // 5. Applique l'opacité globale
    color = apply_opacity(color);
	
    COLOR = color;
}



