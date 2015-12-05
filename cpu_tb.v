`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:25:28 12/05/2015
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

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;

        forever #10 clk = ~clk;
	end

    initial begin
        rst = 1;
        #195 rst = 0;
        #1000 $finish;
    end
endmodule

