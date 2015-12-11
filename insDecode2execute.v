`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:29:10 12/04/2015 
// Design Name: 
// Module Name:    insDecode2execute 
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
module insDecode2execute(
    input clk,
    input rst,

    input wire[7:0] aluop_input,
    input wire[2:0] alusel_input,
    input wire[31:0] regOp1,
    input wire[31:0] regOp2,
    input wire[4:0] dest_addr,
    input write_or_not,

    output reg[7:0] aluop_output,
    output reg[2:0] alusel_output,
    output reg[31:0] regOp1_output,
    output reg[31:0] regOp2_output,
    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,

    input in_delayslot,
    input wire[31:0] ret_addr,
    input next_delay,

    output reg execute_in_delayslot,
    output reg[31:0] ret_addr_output,
    output reg insDecode_in_delayslot,

    input wire[31:0] insDecode_ins,
    output reg[31:0] insDecode2execute_ins,

    input wire[5:0] control
    );

    always @ (posedge clk) begin
        if(rst == 1) begin
            aluop_output <= 0;
            alusel_output <= 0;
            regOp1_output <= 0;
            regOp2_output <= 0;
            dest_addr_output <= 0;
            write_or_not_output <= 0;
        end else if(control[2] == 0) begin
            aluop_output <= aluop_input;
            alusel_output <= alusel_input;
            regOp1_output <= regOp1;
            regOp2_output <= regOp2;
            dest_addr_output <= dest_addr;
            write_or_not_output <= write_or_not;
            ret_addr_output <= ret_addr;
            execute_in_delayslot <= in_delayslot;
            insDecode_in_delayslot <= next_delay;
            insDecode2execute_ins <= insDecode_ins;
        end
    end

endmodule
