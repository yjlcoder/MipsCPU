`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:18:06 12/05/2015 
// Design Name: 
// Module Name:    cpu 
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
//
//////////////////////////////////////////////////////////////////////////////////
module cpu(
    input rst,
    input clk
    );

    wire[31:0] instAddr;
    wire[31:0] inst;
    wire enabler;

    mips mips0(
        .rst(rst), .clk(clk),
        .ins_input(inst),
        .addr_output(instAddr), .enabler_output(enabler)
    );

    instRom instRom0(
        .enabler(enabler),
        .addr(instAddr),
        .inst(inst)
    );

endmodule

