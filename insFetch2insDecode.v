`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:01 12/04/2015 
// Design Name: 
// Module Name:    insFetch2insDecode 
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

module insFetch2insDecode(
    input clk,
    input rst,
    input wire[31:0] insFetchPC,
    input wire[31:0] insFetchInst,
    output reg[31:0] insDecodePC,
    output reg[31:0] insDecodeInst
    );

    always @ (posedge clk) begin
        if (rst == 1) begin
            insDecodePC <= 0;
            insDecodeInst <= 0;
        end
        else 
        begin
            insDecodePC <= insFetchPC;
            insDecodeInst <= insFetchInst;
        end
    end
endmodule
