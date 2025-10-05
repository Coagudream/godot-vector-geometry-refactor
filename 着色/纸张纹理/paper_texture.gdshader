shader_type canvas_item;

// 可调整的参数
uniform vec4 paper_color : source_color = vec4(0.95, 0.93, 0.88, 1.0); // 纸张基础颜色
uniform float noise_scale : hint_range(0.1, 10.0) = 2.0; // 基础噪声缩放
uniform float fiber_strength : hint_range(0.0, 1.0) = 0.3; // 纤维纹理强度
uniform float roughness : hint_range(0.0, 1.0) = 0.2; // 表面粗糙度
uniform float grain_strength : hint_range(0.0, 1.0) = 0.3; // 颗粒强度
uniform float grain_scale : hint_range(1.0, 20.0) = 10.0; // 颗粒大小

// 简单噪声函数
float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

// Perlin噪声实现
float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = random(i + vec2(0.0, 0.0));
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// 分形布朗运动（fbm）用于基础纹理
float fbm(vec2 uv) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    for (int i = 0; i < 6; ++i) {
        v += a * noise(uv);
        uv = uv * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

// 用于颗粒感的单独噪声
float grain_noise(vec2 uv) {
    return random(uv);
}

void fragment() {
    // 计算缩放后的UV坐标
    vec2 scaled_uv = UV * noise_scale;
    vec2 grain_uv = UV * grain_scale;

    // 生成基础纸张噪声
    float paper_noise = fbm(scaled_uv);

    // 添加纤维纹理
    float fiber_noise = fbm(scaled_uv * vec2(5.0, 0.5)) * fiber_strength;

    // 组合基础纹理
    float texture_value = paper_noise * (1.0 - fiber_strength) + fiber_noise;

    // 生成颗粒噪声
    float grain = grain_noise(grain_uv) * grain_strength;

    // 计算最终颜色
    vec3 final_color = paper_color.rgb;

    // 添加粗糙度影响
    final_color = mix(final_color, final_color * (1.0 - roughness), texture_value);

    // 添加颗粒效果
    final_color = mix(final_color, final_color * (1.0 - grain), grain_strength);

    // 输出结果
    COLOR = vec4(final_color, paper_color.a);
}