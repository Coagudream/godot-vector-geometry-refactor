shader_type canvas_item;

// 可调整的参数
uniform vec4 bg_color : source_color = vec4(0.1, 0.1, 0.2, 1.0); // 背景颜色
uniform vec4 shape_color : source_color = vec4(1.0, 1.0, 1.0, 0.3); // 形状颜色
uniform float scroll_speed : hint_range(0.0, 2.0) = 0.5; // 滚动速度
uniform float shape_scale : hint_range(0.1, 5.0) = 1.0; // 形状缩放
uniform float density : hint_range(0.1, 10.0) = 0.5; // 形状密度
uniform float shape_size : hint_range(0.1, 0.5) = 0.2; // 固定形状大小

// 随机函数
float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

// 圆形距离场
float circle(vec2 uv, vec2 pos, float radius) {
    return smoothstep(radius, radius - 0.02, length(uv - pos));
}

// 三角形距离场
float triangle(vec2 uv, vec2 pos, float size) {
    uv -= pos;
    float d = abs(uv.y) + abs(uv.x * 1.732) - size;
    return smoothstep(0.02, 0.0, d);
}

// 方形距离场
float square(vec2 uv, vec2 pos, float size) {
    vec2 d = abs(uv - pos);
    float max_dist = max(d.x, d.y);
    return smoothstep(size, size - 0.02, max_dist);
}

void fragment() {
    // 计算滚动UV
    vec2 scrolled_uv = UV + vec2(TIME * scroll_speed, TIME * scroll_speed * 0.5);
    vec2 tiled_uv = fract(scrolled_uv * shape_scale * density);
    vec2 cell_id = floor(scrolled_uv * shape_scale * density);
    
    // 只基于单元格ID生成随机形状类型
    float rand = random(cell_id);
    float shape_type = floor(rand * 3.0); // 0:圆, 1:三角, 2:方形
    
    // 固定位置为中心，固定大小
    vec2 pos = tiled_uv - vec2(0.5); // 居中
    float size = shape_size;
    
    // 计算形状
    float shape = 0.0;
    if (shape_type == 0.0) {
        shape = circle(pos, vec2(0.0), size);
    } else if (shape_type == 1.0) {
        shape = triangle(pos, vec2(0.0), size);
    } else {
        shape = square(pos, vec2(0.0), size);
    }
    
    // 混合颜色
    vec4 final_color = bg_color;
    final_color = mix(final_color, shape_color, shape);
    
    COLOR = final_color;
}