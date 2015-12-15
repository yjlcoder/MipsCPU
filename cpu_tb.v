`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:25:48 12/15/2015
// Design Name:   cpu
// Module Name:   E:/HDL/MipsCPU/cpu_tb.v
// Project Name:  MipsCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

	// Inputs
	reg rst;
	reg clk;
	reg [4:0] btn;

	// Outputs
	wire [1:0] blue_out;
	wire [2:0] red_out;
	wire [2:0] green_out;
	wire Hsync_out;
	wire Vsync_out;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk), 
		.btn(btn), 
		.blue_out(blue_out), 
		.red_out(red_out), 
		.green_out(green_out), 
		.Hsync_out(Hsync_out), 
		.Vsync_out(Vsync_out)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		btn = 0;

		// Wait 100 ns for global reset to finish
		#500;
        rst = 0;
        
		// Add stimulus here

	end

    always #10 clk = ~clk;
      
endmodule

