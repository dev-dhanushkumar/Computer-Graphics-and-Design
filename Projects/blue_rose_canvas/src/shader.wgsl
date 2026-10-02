struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) uv: vec2<f32>,
}

@vertex
fn vs_main(@builtin(vertex_index) in_vertex_index: u32) -> VertexOutput {
    var out: VertexOutput;

    // Generates a massive triangle that perfectly covers the screen without gaps
    let uv_x = f32((in_vertex_index << 1u) & 2u);
    let uv_y = f32(in_vertex_index & 2u);

    let x = uv_x * 2.0 - 1.0;
    let y = uv_y * 2.0 - 1.0;

    out.clip_position = vec4<f32>(x, y, 0.0, 1.0);
    out.uv = vec2<f32>(x, y);

    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let uv = in.uv;

    // 1. Convert Cartesian (X,Y) to Polar (Radius, Angle)
    let radius = length(uv);
    let angle = atan2(uv.y, uv.x);

    // 2. The Rhodonea Math (Creating the petals)
    let petals = sin(angle * 5.0);

    // Remap the wave from [-1, 1] to [0.4, 1.0] to give the flower a solid core
    let rose_boundary = 0.4 + 0.6 * (petals * 0.5 + 0.5);

    // 3. Anti-Aliasing the edges
    let mask = smoothstep(rose_boundary + 0.02, rose_boundary - 0.02, radius);

    // 4. Color Gradient Calculation
    let depth = 1.0 - (radius / rose_boundary);
    let deep_blue = vec3<f32>(0.02, 0.05, 0.4);
    let bright_cyan = vec3<f32>(0.2, 0.9, 1.0);
    let rose_color = mix(deep_blue, bright_cyan, depth);

    // 5. Final Composite against background
    let bg_color = vec3<f32>(0.01, 0.01, 0.03);
    let final_color = mix(bg_color, rose_color, mask);

    return vec4<f32>(final_color, 1.0);
}
