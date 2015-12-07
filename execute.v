`timescale 1ns / 1ps
`include "defineOperator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:23 12/04/2015 
// Design Name: 
// Module Name:    execute 
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
module execute(
    input rst,

    input wire[7:0] aluop_input,
    input wire[2:0] alusel_input,
    input wire[31:0] regOp1,
    input wire[31:0] regOp2,
    input wire[4:0] dest_addr,
    input write_or_not,

    input wire memory_HILO_enabler,
    input wire[31:0] memory_HILO_HI,
    input wire[31:0] memory_HILO_LO,

    input wire memory2writeback_HILO_enabler,
    input wire[31:0] memory2writeback_HILO_HI,
    input wire[31:0] memory2writeback_HILO_LO,

    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,
    output reg[31:0] wdata_output,

    output reg execute_HILO_enabler,
    output reg[31:0] execute_HILO_HI,
    output reg[31:0] execute_HILO_LO
    );

    reg [31:0] opOut;
    reg [31:0] hi;
    reg [31:0] lo;

    always @ (*) begin
        execute_HILO_enabler <= 0;
        if(rst == 1) begin
            opOut <= 0;
        end else begin
            case (aluop_input)
                `ALUOP_AND: begin
                    opOut <= regOp1 & regOp2;
                end
                `ALUOP_OR: begin
                    opOut <= regOp1 | regOp2;
                end
                `ALUOP_XOR: begin
                    opOut <= regOp1 ^ regOp2;
                end
                `ALUOP_NOR: begin
                    opOut <= ~(regOp1 | regOp2);
                end
                `ALUOP_ANDI: begin
                    opOut <= regOp1 & regOp2;
                end
                `ALUOP_ORI: begin
                    opOut <= regOp1 | regOp2;
                end
                `ALUOP_XORI: begin
                    opOut <= regOp1 ^ regOp2;
                end
                `ALUOP_LUI: begin
                    opOut <= regOp2;
                end
                `ALUOP_SLL: begin
                    opOut <= regOp2 << regOp1;
                end
                `ALUOP_SLLV: begin
                    opOut <= regOp2 << regOp1;
                end
                `ALUOP_SRL: begin
                    opOut <= regOp2 >> regOp1;
                end
                `ALUOP_SRLV: begin
                    opOut <= regOp2 >> regOp1;
                end
                `ALUOP_SRA: begin
                    opOut <= $signed(regOp2) >>> regOp1;
                end
                `ALUOP_SRAV: begin
                    opOut <= $signed(regOp2) >>> regOp1;
                end
                `ALUOP_MOVN: begin
                    opOut <= regOp1;
                end
                `ALUOP_MOVZ: begin
                    opOut <= regOp1;
                end
                `ALUOP_MFHI: begin
                    opOut <= hi;
                end
                `ALUOP_MFLO: begin
                    opOut <= lo;
                end
                `ALUOP_MTHI: begin
                    execute_HILO_enabler <= 1'b1;
                    execute_HILO_HI <= regOp1;
                end
                `ALUOP_MTLO: begin
                    execute_HILO_enabler <= 1'b1;
                    execute_HILO_LO <= regOp1;
                end
                default:
                    opOut <= 0;
            endcase
        end
    end

    always @ (*) begin
        dest_addr_output <= dest_addr;
        write_or_not_output <= write_or_not;
        case (alusel_input)
            `ALUSEL_LOGIC:
                wdata_output <= opOut;
            `ALUSEL_SHIFT:
                wdata_output <= opOut;
            `ALUSEL_MOVE:
                wdata_output <= opOut;
            default:
                wdata_output <= 0;
        endcase
    end

    always @ (*) begin
        if (memory_HILO_enabler == 1) begin
            hi = memory_HILO_HI;
            lo = memory_HILO_LO;
        end else begin
            if (memory2writeback_HILO_enabler == 1) begin
                hi = memory2writeback_HILO_HI;
                lo = memory2writeback_HILO_LO;
            end
        end
    end
endmodule
