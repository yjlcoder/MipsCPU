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

    /* From insFetch2insDecode module */
    input wire[31:0] insDecode_pc,
    input wire[31:0] insDecode_ins,
    
    /* From regfile module */
    input wire[31:0] reg1_data_input,
    input wire[31:0] reg2_data_input,

    /* From execute module */
    input execute_WriteOrNot,
    input wire[4:0] execute_DestAddr,
    input wire[31:0] execute_Wdata,

    /* From memory module */
    input memory_WriteOrNot,
    input wire[4:0] memory_DestAddr,
    input wire[31:0] memory_Wdata,

    /* To regfile module */
    output reg reg1_read_enabler,
    output reg reg2_read_enabler,
    output reg[4:0] reg1_addr_output,
    output reg[4:0] reg2_addr_output,


    /* To insDecode2execute module */
    output reg[7:0] aluop_output,
    output reg[2:0] alusel_output,
    output reg[31:0] regOp1,
    output reg[31:0] regOp2,
    output reg[4:0] dest_addr,
    output reg write_or_not
    );

    reg valid;
    reg [31:0] imm;

    wire[5:0] op1 = insDecode_ins[31:26]; //Ö¸ÁîÂë
    wire[4:0] op2 = insDecode_ins[10:6]; //NOP & SSNOP
    wire[5:0] op3 = insDecode_ins[5:0]; // ¹¦ÄÜÂë
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
                    aluop_output <= `ALUOP_ORI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                    valid <= 1;
                end

                `OP_ANDI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_ANDI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                    valid <= 1;
                end

                `OP_XORI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_XORI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                    valid <= 1;
                end
                    
                `OP_LUI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LUI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {insDecode_ins[15:0], 16'b0};
                    dest_addr <= insDecode_ins[20:16];
                    valid <= 1;
                end

                `OP_SPECIAL: begin
                    case (op3)
                        `OP_AND: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_AND;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_OR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_OR;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_XOR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_XOR;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_NOR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_NOR;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_SRL: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRL;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            imm <= op2;
                            valid <= 1;
                        end

                        `OP_SRA: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRA;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            imm <= op2;
                            valid <= 1;
                        end

                        `OP_SLLV: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SLLV;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_SRLV: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRLV;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            imm <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_SRAV: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRAV;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            imm <= insDecode_ins[15:11];
                            valid <= 1;
                        end

                        `OP_SYNC: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_NOP;
                            alusel_output <= `ALUSEL_NOP;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 1;
                            valid <= 1;
                        end

                        `OP_MOVN: begin
                            aluop_output <= `ALUOP_MOVN;
                            alusel_output <=`ALUSEL_MOVE;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            valid <= 1;
                            if(regOp2 != 0) begin
                                write_or_not <= 1;
                            end else begin
                                write_or_not <= 0;
                            end
                        end
                        
                        `OP_MOVZ: begin
                            aluop_output <= `ALUOP_MOVZ;
                            alusel_output <=`ALUSEL_MOVE;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            valid <= 1;
                            if(regOp2 == 0) begin
                                write_or_not <= 1;
                            end else begin
                                write_or_not <= 0;
                            end
                        end 

                        `OP_SLL: begin
                            if (op2 == `OP_NOP10_6) begin
                                write_or_not <= 0;
                                aluop_output <= `ALUOP_NOP;
                                alusel_output <= `ALUSEL_NOP;
                                dest_addr <= insDecode_ins[15:11];
                                reg1_read_enabler <= 0;
                                reg2_read_enabler <= 0;
                                valid <= 1;
                            end else begin
                                write_or_not <= 1'b1;
                                aluop_output <= `ALUOP_SLL;
                                alusel_output <= `ALUSEL_SHIFT;
                                reg1_read_enabler <= 0;
                                reg2_read_enabler <= 1;
                                dest_addr = insDecode_ins[15:11];
                                imm <= op2;
                                valid <= 1;
                            end
                        end
                    endcase
                end
            endcase
        end
    end

    always @ (*) begin
        if (rst == 1) regOp1 = 0;
        else if (reg1_read_enabler == 1 && execute_WriteOrNot == 1 && execute_DestAddr == reg1_addr_output)
            regOp1 <= execute_Wdata;
        else if (reg1_read_enabler == 1 && memory_WriteOrNot == 1 && memory_DestAddr == reg1_addr_output)
            regOp1 <= memory_Wdata;
        else if (reg1_read_enabler == 1)
            regOp1 = reg1_data_input;
        else 
            regOp1 <= imm;
    end

    always @ (*) begin
        if (rst == 1) regOp1 = 0;
        else if (reg2_read_enabler == 1 && execute_WriteOrNot == 1 && execute_DestAddr == reg2_addr_output)
            regOp2 <= execute_Wdata;
        else if (reg2_read_enabler == 1 && memory_WriteOrNot == 1 && memory_DestAddr == reg2_addr_output)
            regOp2 <= memory_Wdata;
        else if (reg2_read_enabler == 1) 
            regOp2 = reg2_data_input;
        else 
            regOp2 <= imm;
    end

endmodule

