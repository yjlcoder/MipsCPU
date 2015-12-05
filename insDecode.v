`timescale 1ns / 1ps
`include "defineOperator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:25 12/04/2015 
// Design Name: 
// Module Name:    insDecode 
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


module insDecode(
    input rst,
    input wire[31:0] insDecode_pc,
    input wire[31:0] insDecode_ins,
    
    input wire[31:0] reg1_data_input,
    input wire[31:0] reg2_data_input,

    output reg reg1_read_enabler,
    output reg reg2_read_enabler,
    output reg[4:0] reg1_addr_output,
    output reg[4:0] reg2_addr_output,

    output reg[7:0] aluop_output,
    output reg[2:0] alusel_output,
    output reg[31:0] regOp1,
    output reg[31:0] regOp2,
    output reg[4:0] dest_addr,
    output reg write_or_not
    );

    reg valid;
    reg [31:0] imm;

    wire[5:0] op1 = insDecode_ins[31:26];
    wire[4:0] op2 = insDecode_ins[10:6];
    wire[5:0] op3 = insDecode_ins[5:0];
    wire[4:0] op4 = insDecode_ins[20:16];

    /* Decode */
    always @ (*) begin
        if (rst == 1) begin
            aluop_output <= 0;
            alusel_output <= 0;
            dest_addr <= 0;
            write_or_not <= 0;
            valid <= 0;
            reg1_read_enabler <= 0;
            reg2_read_enabler <= 0;
            reg1_addr_output <= 0;
            reg2_addr_output <= 0;
            imm <= 0;
        end else begin
            aluop_output <= 0;
            alusel_output <= 0;
            dest_addr <= insDecode_ins[15:11];
            write_or_not <= 0;
            valid <= 0;
            reg1_read_enabler <= 0;
            reg2_read_enabler <= 0;
            reg1_addr_output <= insDecode_ins[25:21];
            reg2_addr_output <= insDecode_ins[20:16];
            imm <= 0;
            case(op1)
                `OP_ORI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_OR;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                    valid <= 1;
                end

            endcase
        end
    end

    always @ (*) begin
        if (rst == 1) regOp1 = 0;
        else if (reg1_read_enabler == 1) regOp1 = reg1_data_input;
        else regOp1 <= imm;
    end

    always @ (*) begin
        if (rst == 1) regOp1 = 0;
        else if (reg2_read_enabler == 1) regOp2 = reg2_data_input;
        else regOp2 <= imm;
    end

endmodule

