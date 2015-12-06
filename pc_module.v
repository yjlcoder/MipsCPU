`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    13:46:28 12/04/2015
// Design Name:
// Module Name:    pc_module
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//a
//////////////////////////////////////////////////////////////////////////////////
module pc_module(
	input clk, //clock
	input rst,
	output reg[31:0] pc,
	output reg ce
    );

    always @ (posedge clk) fork
        if (rst == 1) ce <= 0;
        else ce <= 1;
        if (ce == 0) pc <= 0;
        else pc <= pc + 4;
    join
endmodule