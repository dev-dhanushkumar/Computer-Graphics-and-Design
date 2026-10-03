# Procedural Blue Rose Canvas

A bare-metal 2D procedural graphics engine built in Rust using `wgpu` and `winit`. This project renders an animated, mathematically generated Rhodonea curve (a "blue rose") entirely on the GPU via WGSL fragment shaders. 

It completely bypasses high-level creative coding frameworks to directly interface with the graphics card, serving as an exploration of low-level graphics pipelines, state machine windowing, and CPU-to-GPU memory bridges.

## Features

* **Strict Trait-Based Windowing:** Utilizes the modern `winit` (v0.30+) `ApplicationHandler` state machine to manage OS-level events and continuous redraw requests.
* **Bare-Metal GPU Pipeline:** Built on the bleeding-edge `wgpu` (v0.22+) crate, featuring manual render pass configuration, surface presentation via the GPU queue, and zero-cost full-screen triangle vertex manipulation.
* **Procedural WGSL Math:** Calculates pixels directly on the fragment shader using Cartesian-to-Polar conversions, smoothstep anti-aliasing, and dynamic color interpolation.
* **Uniform Buffer Animation:** Implements a 16-byte aligned memory bridge to pass real-time CPU clock data into the GPU shader, driving continuous rotation and breathing scale animations.


## Running the Project

Clone the repository and run it via Cargo. The event loop will instantly compile the WGSL shader and launch the animated canvas.

```bash
git clone https://github.com/dev-dhanushkumar/Computer-Graphics-and-Design.git
cd Project/blue_rose_canvas
cargo run
```

## Phases Of design pictures:

### Blue rose version 0:
<img width="1079" height="782" alt="Screenshot From 2026-10-02 21-43-24" src="https://github.com/user-attachments/assets/c3cf6fd4-afb3-4448-8008-f36f1f135c92" />

### Blue rose version 1:
<img width="923" height="722" alt="Screenshot From 2026-10-02 21-53-01" src="https://github.com/user-attachments/assets/b095b7ba-e773-4887-8542-5597cfc7d368" />

### Blue rose version 2: (Adding animation and time frame)
https://github.com/user-attachments/assets/94203738-48b2-4754-a34f-b913c27786b8



## Project Architecture

- `src/main.rs`: Contains the `winit` event loop and the `wgpu` initialization. It sets up the logical device, configures the sRGB surface, establishes the 16-byte uniform buffer for the time variable, and submits the render passes frame-by-frame.
- `src/shader.wgsl`: The WebGPU Shading Language file. The `@vertex` stage generates a clip-space triangle that spans the entire screen without requiring vertex buffers. The `@fragment` stage calculates the Rhodonea curve `r = cos(k theta)` using polar coordinates to draw and animate the flower.

## License
This project is open-source and available under the MIT License. Feel free to fork it, modify the shader math, and experiment with your own procedural geometry.
