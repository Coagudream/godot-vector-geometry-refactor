shader_type canvas_item;

uniform float radius = 0.4;       // 圆环半径（0到1范围，默认0.4）
uniform float ring_count = 1.0;   // 圆环条数（整数或小数，默认1.0）
uniform vec4 ring_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // 圆环颜色（RGBA，默认红色）
uniform float amplitude = 0.1;    // 波动幅度（0到1范围，默认0.1）

void fragment() {
    // 计算距离中心（0.5, 0.5）的距离（UV是0到1的纹理坐标）
    vec2 center = vec2(0.5, 0.5);
    float dist = length(UV - center);

    // 计算波动效果，使用正弦函数基于时间和角度
    float angle = atan(UV.y - center.y, UV.x - center.x);
    float wave = sin(TIME + angle * ring_count * 10.0) * amplitude;

    // 定义圆环的宽度
    float ring_width = 0.02;

    // 计算圆环的实际半径（包括波动）
    float ring_radius = radius + wave;

    // 判断当前像素是否在圆环范围内
    float ring = smoothstep(ring_radius - ring_width, ring_radius, dist) -
                 smoothstep(ring_radius, ring_radius + ring_width, dist);

    // 输出颜色：如果在圆环范围内，使用指定颜色，否则透明
    if (ring > 0.0) {
        COLOR = vec4(ring_color.rgb, ring * ring_color.a); // 使用alpha控制透明度
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // 透明背景
    }
}