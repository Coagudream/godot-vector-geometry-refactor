shader_type canvas_item;

// 可调整的参数
uniform vec4 border_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // 默认红色
uniform float border_width : hint_range(0.0, 0.5) = 0.1; // 边界宽度
uniform float flash_speed : hint_range(0.1, 10.0) = 2.0; // 闪烁速度
uniform float flash_intensity : hint_range(0.0, 1.0) = 0.5; // 闪烁强度
uniform int flash_mode : hint_range(0, 2) = 0; // 闪烁模式：0=正弦, 1=脉冲, 2=随机

void fragment() {
    // 获取原始颜色
    vec4 original_color = texture(TEXTURE, UV);

    // 计算距离边缘的距离
    float dist = min(min(UV.x, 1.0 - UV.x), min(UV.y, 1.0 - UV.y));

    // 创建边界遮罩
    float border_mask = smoothstep(0.0, border_width, dist);

    // 计算不同的闪烁效果
    float flash = 0.0;
    if (flash_mode == 0) {
        // 正弦波模式
        flash = sin(TIME * flash_speed) * 0.5 + 0.5;
    } else if (flash_mode == 1) {
        // 脉冲模式
        flash = fract(TIME * flash_speed);
    } else if (flash_mode == 2) {
        // 随机模式
        flash = fract(sin(TIME * flash_speed) * 43758.5453);
    }
    flash *= flash_intensity;

    // 设置边界颜色
    vec4 final_border_color = border_color;
    final_border_color.a *= flash * (1.0 - border_mask); // 边界透明度

    // 如果在边界内，使颜色完全透明
    if (border_mask > 0.99) {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // 中心完全透明
    } else {
        COLOR = final_border_color;
    }
}