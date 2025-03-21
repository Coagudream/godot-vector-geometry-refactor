shader_type canvas_item;

uniform float radius = 0.4;         // 圆环中心半径（0到1范围，默认0.4）
uniform int ring_count_total = 3;   // 总圆环数量（整数，默认3）
uniform float ring_variation = 0.1; // 圆环间距/变化幅度（0到1范围，默认0.1）
uniform float ring_speed = 1.0;     //旋转速度
uniform vec4 ring_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // 圆环颜色（RGBA，默认红色）
uniform float amplitude = 0.1;      // 每个圆环的波动幅度（0到1范围，默认0.1）
uniform float ring_width = 0.001;   // 定义圆环的宽度


void fragment() {
    // 计算距离中心（0.5, 0.5）的距离（UV是0到1的纹理坐标）
    vec2 center = vec2(0.5, 0.5);
    float dist = length(UV - center);

    // 初始化最终颜色为透明
    vec4 final_color = vec4(0.0, 0.0, 0.0, 0.0);
    float total_alpha = 0.0; // 跟踪总alpha值以避免过度叠加

    // 遍历每个圆环
    for (int i = 0; i < ring_count_total; i++) {
        // 为每个圆环计算半径（叠加偏移）
        float current_radius = radius + (float(i) * ring_variation);

        // 计算波动效果，使用正弦函数基于时间、角度和圆环索引
        float angle = atan(UV.y - center.y, UV.x - center.x);
        float wave = sin(TIME*ring_speed + angle * (float(i + 1) * 5.0) + float(i)) * amplitude;



        // 计算圆环的实际半径（包括波动）
        float ring_radius = current_radius + wave;

        // 判断当前像素是否在当前圆环范围内
        float ring = smoothstep(ring_radius - ring_width, ring_radius, dist) -
                     smoothstep(ring_radius, ring_radius + ring_width, dist);

        // 如果在圆环范围内，叠加颜色
        if (ring > 0.0) {
            // 确保alpha不会超过1.0，模拟半透明叠加
            float new_alpha = ring * ring_color.a * (1.0 - total_alpha);
            final_color += vec4(ring_color.rgb, new_alpha);
            total_alpha += new_alpha;
        }
    }

    // 输出最终颜色
    COLOR = final_color;
}