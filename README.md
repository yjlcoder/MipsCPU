#MipsCPU

This project is designed for Xilinx Nexys 3, a FPGA board.

This repo contains how to organize your own CPU based on MIPS instruction sets from FPGA, and how to make it work with memories, VGA monitors, buttons.

The CPU holds the frequency of 75MHz, where the frequncy of crystal oscillator is 100MHz. I use 5-stage pipeline technology to build this CPU.

The 5-stages pipelines are:
- Instruction Fetching
- Instruction Decoding
- Execution
- Memory Visiting
- Writing back

ASM Folder: MIPS assembly code
- draw.asm: draw lines and blocks in screen
- myprogram.asm: entry of the program

Design Folder：
- pixel.xlsx: Address of video memory, and the color it presents
