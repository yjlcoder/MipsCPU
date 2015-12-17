`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:50:49 12/16/2015
// Design Name:   btn
// Module Name:   E:/HDL/MipsCPU/btn_tb.v
// Project Name:  MipsCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: btn
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module btn_tb;

	// Inputs
	reg clk;
	reg [4:0] btn;

	// Outputs
	wire we;
	wire enabler;
	wire [31:0] waddr;
	wire [31:0] wdata;
	wire [3:0] select;

	// Instantiate the Unit Under Test (UUT)
	btn_module uut (
		.clk(clk), 
		.btn(btn), 
		.we(we), 
		.enabler(enabler), 
		.waddr(waddr), 
		.wdata(wdata), 
		.select(select)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btn = 0;

		// Wait 100 ns for global reset to finish
		#100 btn = 1;
        #100 btn = 2;
        #100 btn = 4;
        #100 btn = 8;
        #100 btn = 16;
        #100 btn = 7;
        
		// Add stimulus here

	end

    always #10 clk = ~clk;
      
endmodule

