shader_type canvas_item;

uniform float ring_radius = 0.4;       // 圆环半径（0到1范围，默认0.4）
uniform vec4 ring_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // 圆环颜色（RGBA，默认红色）
uniform float ring_width = 0.02;    // 定义圆环的宽度
uniform float smooth_factor = 0.005;    // 定义柔化过渡范围（比原来更小）, 控制柔化程度，值越小边缘越锐利



void fragment() {
    // 计算距离中心（0.5, 0.5）的距离（UV是0到1的纹理坐标）
    vec2 center = vec2(0.5, 0.5);
    float dist = length(UV - center);

    // 判断当前像素是否在圆环范围内
    float ring = smoothstep(ring_radius - ring_width - smooth_factor, ring_radius - ring_width + smooth_factor, dist) -
                 smoothstep(ring_radius + ring_width - smooth_factor, ring_radius + ring_width + smooth_factor, dist);

    // 输出颜色：如果在圆环范围内，使用指定颜色，否则透明
    if (ring > 0.0) {
        COLOR = vec4(ring_color.rgb, ring * ring_color.a); // 使用alpha控制透明度
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // 透明背景
    }
}