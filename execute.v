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

    input wire[31:0] ret_addr,
    input wire in_delayslot,

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

    wire overflow;
    wire reg1_eq_reg2;
    wire reg1_lt_reg2;
    reg[31:0] arch_answer;
    wire[31:0] regOp2_mux;
    wire[31:0] regOp1_not;
    wire[31:0] sum_result;
    wire[31:0] mulOp1;
    wire[31:0] mulOp2;
    wire[63:0] mul_temp;
    reg[63:0] mul_result;

    assign regOp2_mux = ((aluop_input == `ALUOP_SUB) || (aluop_input == `ALUOP_SUBU) || (aluop_input == `ALUOP_SLT)) ? (~regOp2) + 1 : regOp2;

    assign sum_result = regOp1 + regOp2_mux;

    assign overflow = (!regOp1[31] && !regOp2[31] && sum_result[31]) || (regOp1[31] && regOp2[31] && !sum_result[31]);

    assign reg1_lt_reg2 = (aluop_input == `ALUOP_SLT) ? ((regOp1[31] && !regOp2[31]) || (!regOp1[31] && !regOp2[31] && sum_result[31]) || (regOp1[31] && regOp2[31] && sum_result[31])):(regOp1 < regOp2);

    assign regOp1_not = ~regOp1;

    assign mulOp1 = ((( aluop_input == `ALUOP_MUL) || (aluop_input == `ALUOP_MULT)) && (regOp1[31] == 1)) ? (~regOp1) + 1 : regOp1;

    assign mulOp2 = ((( aluop_input == `ALUOP_MUL) || (aluop_input == `ALUOP_MULT)) && (regOp2[31] == 1)) ? (~regOp2) + 1 : regOp2;

    assign mul_temp = mulOp1 * mulOp2;

    always @ (*) begin
        if (rst == 1'b1) begin
            arch_answer <= 0;
        end else begin
            case (aluop_input)
                `ALUOP_SLT:
                    arch_answer <= reg1_lt_reg2;
                `ALUOP_SLTU: 
                    arch_answer <= reg1_lt_reg2;

                `ALUOP_ADD:
                    arch_answer <= sum_result;
                `ALUOP_ADDU:
                    arch_answer <= sum_result;
                `ALUOP_ADDI:
                    arch_answer <= sum_result;
                `ALUOP_ADDIU:
                    arch_answer <= sum_result;

                `ALUOP_SUB:
                    arch_answer <= sum_result;
                `ALUOP_SUBU:
                    arch_answer <= sum_result;
                `ALUOP_CLZ: 
                    arch_answer <= regOp1[31] ? 0 : regOp1[30] ? 1 : regOp1[29] ? 2 :
                                                     regOp1[28] ? 3 : regOp1[27] ? 4 : regOp1[26] ? 5 :
                                                     regOp1[25] ? 6 : regOp1[24] ? 7 : regOp1[23] ? 8 : 
                                                     regOp1[22] ? 9 : regOp1[21] ? 10 : regOp1[20] ? 11 :
                                                     regOp1[19] ? 12 : regOp1[18] ? 13 : regOp1[17] ? 14 : 
                                                     regOp1[16] ? 15 : regOp1[15] ? 16 : regOp1[14] ? 17 : 
                                                     regOp1[13] ? 18 : regOp1[12] ? 19 : regOp1[11] ? 20 :
                                                     regOp1[10] ? 21 : regOp1[9] ? 22 : regOp1[8] ? 23 : 
                                                     regOp1[7] ? 24 : regOp1[6] ? 25 : regOp1[5] ? 26 : 
                                                     regOp1[4] ? 27 : regOp1[3] ? 28 : regOp1[2] ? 29 : 
                                                     regOp1[1] ? 30 : regOp1[0] ? 31 : 32 ;
                 `ALUOP_CLO:
                    arch_answer <= regOp1_not[31] ? 0 : regOp1_not[30] ? 1 : regOp1_not[29] ? 2 :
                                                     regOp1_not[28] ? 3 : regOp1_not[27] ? 4 : regOp1_not[26] ? 5 :
                                                     regOp1_not[25] ? 6 : regOp1_not[24] ? 7 : regOp1_not[23] ? 8 : 
                                                     regOp1_not[22] ? 9 : regOp1_not[21] ? 10 : regOp1_not[20] ? 11 :
                                                     regOp1_not[19] ? 12 : regOp1_not[18] ? 13 : regOp1_not[17] ? 14 : 
                                                     regOp1_not[16] ? 15 : regOp1_not[15] ? 16 : regOp1_not[14] ? 17 : 
                                                     regOp1_not[13] ? 18 : regOp1_not[12] ? 19 : regOp1_not[11] ? 20 :
                                                     regOp1_not[10] ? 21 : regOp1_not[9] ? 22 : regOp1_not[8] ? 23 : 
                                                     regOp1_not[7] ? 24 : regOp1_not[6] ? 25 : regOp1_not[5] ? 26 : 
                                                     regOp1_not[4] ? 27 : regOp1_not[3] ? 28 : regOp1_not[2] ? 29 : 
                                                     regOp1_not[1] ? 30 : regOp1_not[0] ? 31 : 32 ;
                 default:
                    arch_answer <= 0;
            endcase
        end
    end

    always @ (*) begin
        if (rst == 1) begin
            mul_result <= 0;
        end else if((aluop_input == `ALUOP_MULT) || (aluop_input == `ALUOP_MUL)) begin
            if (regOp1[31] ^ regOp2[31] == 1) begin
                mul_result <= ~mul_temp + 1;
            end else begin
                mul_result <= mul_temp;
            end
        end else begin
            mul_result <= mul_temp;
        end
    end

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
        if((aluop_input == `ALUOP_ADD || aluop_input == `ALUOP_ADDI || aluop_input == `ALUOP_SUB) && overflow == 1) 
            write_or_not_output <= 0;
        else
            write_or_not_output <= write_or_not;

        case (alusel_input)
            `ALUSEL_LOGIC:
                wdata_output <= opOut;
            `ALUSEL_SHIFT:
                wdata_output <= opOut;
            `ALUSEL_MOVE:
                wdata_output <= opOut;
            `ALUSEL_ARCH:
                wdata_output <= arch_answer;
            `ALUSEL_MUL:
                wdata_output <= mul_result;
            `ALUSEL_JUMP_BRANCH:
                wdata_output <= ret_addr;
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

    always @ (*) begin
        if(rst == 1) begin
            execute_HILO_enabler <= 0;
            execute_HILO_HI <= 0;
            execute_HILO_LO <= 0;
        end else 
            case (aluop_input)
                `ALUOP_MULT, `ALUOP_MULTU: begin
                    execute_HILO_enabler <= 1;
                    execute_HILO_HI <= mul_result[63:32];
                    execute_HILO_LO <= mul_result[31:0];
                end
                `ALUOP_MTHI: begin
                    execute_HILO_enabler <= 1;
                    execute_HILO_HI <= regOp1;
                    execute_HILO_LO <= lo;
                end
                `ALUOP_MTLO: begin
                    execute_HILO_enabler <= 1;
                    execute_HILO_HI <= hi;
                    execute_HILO_LO <= regOp1;
                end
                default:
                    execute_HILO_enabler <= 0;
            endcase
    end
endmodule
