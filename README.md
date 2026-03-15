# Sequential-1D-Convolution-Engine-in-Verilog
This project implements a parameterized hardware accelerator for 1D convolution, a core operation in Signal Processing and Convolutional Neural Networks (CNNs). The design utilizes a sliding window architecture with a shift register to process streaming data in real-time.
Project Overview
This repository contains a high-speed, hardware-efficient 1D Convolution Engine implemented in Verilog. Convolution is a fundamental operation in Digital Signal Processing (DSP) and Convolutional Neural Networks (CNNs). This implementation utilizes a sliding window shift-register architecture to process streaming data with single-cycle throughput.
I designed this module to be fully parameterized, allowing for seamless integration into various hardware acceleration tasks, such as image filtering or audio effect processing.Key FeaturesFully Parameterized Design: Configurable DATA_WIDTH and KERNEL_SIZE via Verilog parameters to suit different precision and filter requirements.Streaming Data Interface: Supports synchronous data flow using valid_in and valid_out handshaking signals.Parallel Computation: Implements a combinational multiply-accumulate (MAC) tree that computes the convolution sum in parallel for maximum throughput.Optimized Bit-Width: Output bit-width is automatically calculated using $clog2 to prevent overflow while minimizing hardware area.Technical Specifications

Architecture
The module consists of a shift register chain that captures a window of input data. On every clock cycle where valid_in is high, the data shifts, and the core logic performs:
DATA_OUT=  (Data_Window[0] * Kernel[0]) + ....... + (Data_Window[k-1] * Kernel[k-1])

Simulation Results
The testbench (tb_conv_s.v) verifies the design by applying a kernel [1, 2, 1] to a stream of signed integers.

Waveform Analysis
A screenshot of the simulation (conv_sim.jpg) and the RTL schematic (schematic_conv.jpg) can be found in the repository to verify timing accuracy and gate-level logic.

How to Use Simulation: 
Run the provided testbench using Vivado, ModelSim, or Icarus Verilog.
Synthesis: Import conv_s.v into your FPGA toolchain and set the parameters to your desired specifications.
