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
    output reg write_or_not,

    /*(branch)*/
    input in_delayslot,
    //TO PC
    output reg branch_flag_output,
    output reg [31:0] branch_target_output,
    //TO execute
    output reg in_delayslot_output,
    output reg next_delay,
    output reg [31:0] ret_addr,

    /* ram */
    output wire[31:0] insDecode_ins_output
    );

    reg [31:0] imm;

    wire[5:0] op1 = insDecode_ins[31:26]; //Ö¸ÁîÂë
    wire[4:0] op2 = insDecode_ins[10:6]; //NOP & SSNOP
    wire[5:0] op3 = insDecode_ins[5:0]; // ¹¦ÄÜÂë
    wire[4:0] op4 = insDecode_ins[20:16]; 

    wire[31:0] pc_8;
    wire[31:0] pc_4;
    wire[31:0] imm_sll2_signedext;

    assign pc_8 = insDecode_pc + 8;
    assign pc_4 = insDecode_pc + 4;
    assign imm_sll2_signedext = {{14{insDecode_ins[15]}}, insDecode_ins[15:0], 2'b00};
    assign insDecode_ins_output = insDecode_ins;

    /* Decode */
    always @ (*) begin
        if (rst == 1) begin
            aluop_output <= 0;
            alusel_output <= 0;
            dest_addr <= 0;
            write_or_not <= 0;
            reg1_read_enabler <= 0;
            reg2_read_enabler <= 0;
            reg1_addr_output <= 0;
            reg2_addr_output <= 0;
            imm <= 0;
            ret_addr <= 0;
            branch_target_output <= 0;
            branch_flag_output <= 0;            
            next_delay <= 0;
        end else if (in_delayslot == 1) begin
            aluop_output <= 0;
            alusel_output <= 0;
            dest_addr <= 0;
            write_or_not <= 0;
            reg1_read_enabler <= 0;
            reg2_read_enabler <= 0;
            reg1_addr_output <= 0;
            reg2_addr_output <= 0;
            imm <= 0;
            ret_addr <= 0;
            branch_target_output <= 0;
            branch_flag_output <= 0;            
            next_delay <= 0;
        end else begin
            aluop_output <= 0;
            alusel_output <= 0;
            dest_addr <= insDecode_ins[15:11];
            write_or_not <= 0;
            reg1_read_enabler <= 0;
            reg2_read_enabler <= 0;
            reg1_addr_output <= insDecode_ins[25:21];
            reg2_addr_output <= insDecode_ins[20:16];
            imm <= 0;
            ret_addr <= 0;
            branch_target_output <= 0;
            branch_flag_output <= 0;            
            next_delay <= 0;
            case(op1)
                `OP_ORI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_ORI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_ANDI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_ANDI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_XORI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_XORI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end
                    
                `OP_LUI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LUI;
                    alusel_output <= `ALUSEL_LOGIC;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    imm <= {insDecode_ins[15:0], 16'b0};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_ADDI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_ADDI;
                    alusel_output <= `ALUSEL_ARCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    if(insDecode_ins[15] == 1'b1)
                        imm <= {16'hffff, insDecode_ins[15:0]};
                    else
                        imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_ADDIU: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_ADDIU;
                    alusel_output <= `ALUSEL_ARCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    if(insDecode_ins[15] == 1'b1)
                        imm <= {16'hffff, insDecode_ins[15:0]};
                    else
                        imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_SLTI: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_SLT;
                    alusel_output <= `ALUSEL_ARCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    if(insDecode_ins[15] == 1'b1)
                        imm <= {16'hffff, insDecode_ins[15:0]};
                    else
                        imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_SLTIU: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_SLTU;
                    alusel_output <= `ALUSEL_ARCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    if(insDecode_ins[15] == 1'b1)
                        imm <= {16'hffff, insDecode_ins[15:0]};
                    else
                        imm <= {16'b0, insDecode_ins[15:0]};
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_J: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_J;
                    alusel_output <= `ALUSEL_JUMP_BRANCH;
                    reg1_read_enabler <= 0;
                    reg2_read_enabler <= 0;
                    ret_addr <= 0;
                    branch_flag_output <= 1;
                    next_delay <= 1;
                    branch_target_output <= {pc_4[31:28], insDecode_ins[25:0], 2'b00};
                end

                `OP_JAL: begin
                    write_or_not <= 1;
                    dest_addr <= 5'b11111;
                    aluop_output <= `ALUOP_JAL;
                    alusel_output <= `ALUSEL_JUMP_BRANCH;
                    reg1_read_enabler <= 0;
                    reg2_read_enabler <= 0;
                    ret_addr <= pc_8;
                    branch_flag_output <= 1;
                    next_delay <= 1;
                    branch_target_output <= {pc_4[31:28], insDecode_ins[25:0], 2'b00};
                end

                `OP_BEQ: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_BEQ;
                    alusel_output <= `ALUSEL_JUMP_BRANCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                    if(regOp1 == regOp2) begin
                        branch_target_output <= pc_4 + imm_sll2_signedext;
                        branch_flag_output <= 1;
                        next_delay <= 1;
                    end
                end

                `OP_BGTZ: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_BGTZ;
                    alusel_output <= `ALUSEL_JUMP_BRANCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    if(regOp1[31] == 0 && regOp1 != 0) begin
                        branch_target_output <= pc_4 + imm_sll2_signedext;
                        branch_flag_output <= 1;
                        next_delay <= 1;
                    end
                end

                `OP_BLEZ: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_BLEZ;
                    alusel_output <= `ALUSEL_JUMP_BRANCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    if(regOp1[31] == 1 && regOp1 == 0) begin
                        branch_target_output <= pc_4 + imm_sll2_signedext;
                        branch_flag_output <= 1;
                        next_delay <= 1;
                    end
                end

                `OP_BNE: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_BLEZ;
                    alusel_output <= `ALUSEL_JUMP_BRANCH;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                    if(regOp1 != regOp2) begin
                        branch_target_output <= pc_4 + imm_sll2_signedext;
                        branch_flag_output <= 1;
                        next_delay <= 1;
                    end
                end
                
                `OP_LB: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LB;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_LBU: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LBU;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_LH: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LH;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_LHU: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LHU;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_LW: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LW;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 0;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_LWL: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LWL;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_LWR: begin
                    write_or_not <= 1;
                    aluop_output <= `ALUOP_LWR;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                    dest_addr <= insDecode_ins[20:16];
                end

                `OP_SB: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_SB;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                end

                `OP_SH: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_SH;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                end

                `OP_SW: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_SW;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                end

                `OP_SWL: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_SWL;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                end

                `OP_SWR: begin
                    write_or_not <= 0;
                    aluop_output <= `ALUOP_SWR;
                    alusel_output <= `ALUSEL_SL;
                    reg1_read_enabler <= 1;
                    reg2_read_enabler <= 1;
                end

                `OP_REGIMM: begin
                    case(op4)
                        `OP_BGEZ: begin
                            write_or_not <= 0;
                            aluop_output <= `ALUOP_BGEZ;
                            alusel_output <= `ALUSEL_JUMP_BRANCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            if(regOp1[31] == 0) begin
                                branch_target_output <= pc_4 + imm_sll2_signedext;
                                branch_flag_output <= 1;
                                next_delay <= 1;
                            end
                        end

                        `OP_BGEZAL: begin
                            write_or_not <= 1;
                            dest_addr <= 5'b11111;
                            aluop_output <= `ALUOP_BGEZAL;
                            alusel_output <= `ALUSEL_JUMP_BRANCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            ret_addr <= pc_8;
                            if(regOp1[31] == 0) begin
                                branch_target_output <= pc_4 + imm_sll2_signedext;
                                branch_flag_output <= 1;
                                next_delay <= 1;
                            end
                        end

                        `OP_BLTZ : begin
                            write_or_not <= 0;
                            aluop_output <= `ALUOP_BGEZAL;
                            alusel_output <= `ALUSEL_JUMP_BRANCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            ret_addr <= pc_8;
                            if(regOp1[31] == 1) begin
                                branch_target_output <= pc_4 + imm_sll2_signedext;
                                branch_flag_output <= 1;
                                next_delay <= 1;
                            end
                        end

                        `OP_BLTZAL : begin
                            write_or_not <= 1;
                            dest_addr <= 5'b11111;
                            aluop_output <= `ALUOP_BGEZAL;
                            alusel_output <= `ALUSEL_JUMP_BRANCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            ret_addr <= pc_8;
                            if(regOp1[31] == 1) begin
                                branch_target_output <= pc_4 + imm_sll2_signedext;
                                branch_flag_output <= 1;
                                next_delay <= 1;
                            end
                        end
                    endcase
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
                        end

                        `OP_OR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_OR;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                        end

                        `OP_XOR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_XOR;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                        end

                        `OP_NOR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_NOR;
                            alusel_output <= `ALUSEL_LOGIC;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                        end

                        `OP_SRL: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRL;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            imm <= op2;
                        end

                        `OP_SRA: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRA;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                            imm <= op2;
                        end

                        `OP_SLLV: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SLLV;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            dest_addr <= insDecode_ins[15:11];
                        end

                        `OP_SRLV: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRLV;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            imm <= insDecode_ins[15:11];
                        end

                        `OP_SRAV: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_SRAV;
                            alusel_output <= `ALUSEL_SHIFT;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            imm <= insDecode_ins[15:11];
                        end

                        `OP_SYNC: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_NOP;
                            alusel_output <= `ALUSEL_NOP;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 1;
                        end

                        `OP_MOVN: begin
                            aluop_output <= `ALUOP_MOVN;
                            alusel_output <=`ALUSEL_MOVE;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
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
                            if(regOp2 == 0) begin
                                write_or_not <= 1;
                            end else begin
                                write_or_not <= 0;
                            end
                        end 

                        `OP_MFHI:begin
                            aluop_output <= `ALUOP_MFHI;
                            alusel_output <= `ALUSEL_MOVE;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 0;
                            write_or_not <= 1;
                        end

                        `OP_MFLO:begin
                            aluop_output <= `ALUOP_MFLO;
                            alusel_output <= `ALUSEL_MOVE;
                            reg1_read_enabler <= 0;
                            reg2_read_enabler <= 0;
                            write_or_not <= 1;
                        end

                        `OP_MTHI:begin
                            aluop_output <= `ALUOP_MTHI;
                            alusel_output <= `ALUSEL_MOVE;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            write_or_not <= 0;
                        end

                        `OP_MTLO:begin
                            aluop_output <= `ALUOP_MTLO;
                            alusel_output <= `ALUSEL_MOVE;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            write_or_not <= 0;
                        end

                        `OP_ADD:begin
                            aluop_output <= `ALUOP_ADD;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            write_or_not <= 1;
                        end

                        `OP_ADDU: begin
                            aluop_output <= `ALUOP_ADDU;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            write_or_not <= 1;
                        end 

                        `OP_SUB: begin
                            aluop_output <= `ALUOP_SUB;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            write_or_not <= 1;
                        end

                        `OP_SUBU: begin
                            aluop_output <= `ALUOP_SUBU;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            write_or_not <= 1;
                        end

                        `OP_SLT: begin
                            aluop_output <= `ALUOP_SLT;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            write_or_not <= 1;
                        end

                        `OP_SLTU: begin
                            aluop_output <= `ALUOP_SLTU;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            write_or_not <= 1;
                        end

                        `OP_MULT: begin
                            write_or_not <= 0;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            aluop_output <= `ALUOP_MULT;
                            alusel_output <= `ALUSEL_MUL;
                        end

                        `OP_MULTU: begin
                            write_or_not <= 0;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                            aluop_output <= `ALUOP_MULT;
                            alusel_output <= `ALUSEL_MUL;
                        end

                        `OP_JR: begin
                            write_or_not <= 0;
                            aluop_output <= `ALUOP_JR;
                            alusel_output <= `ALUSEL_JUMP_BRANCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            ret_addr <= 0;
                            branch_target_output <= regOp1;
                            branch_flag_output <= 1;
                            next_delay <= 1;
                        end

                        `OP_JALR: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_JALR;
                            alusel_output <= `ALUSEL_JUMP_BRANCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                            dest_addr <= insDecode_ins[15:11];
                            ret_addr <= pc_8;
                            branch_target_output <= regOp1;
                            branch_flag_output <= 1;
                            next_delay <= 1;
                        end

                        `OP_SLL: begin
                            if (op2 == `OP_NOP10_6) begin
                                write_or_not <= 0;
                                aluop_output <= `ALUOP_NOP;
                                alusel_output <= `ALUSEL_NOP;
                                dest_addr <= insDecode_ins[15:11];
                                reg1_read_enabler <= 0;
                                reg2_read_enabler <= 0;
                            end else begin
                                write_or_not <= 1'b1;
                                aluop_output <= `ALUOP_SLL;
                                alusel_output <= `ALUSEL_SHIFT;
                                reg1_read_enabler <= 0;
                                reg2_read_enabler <= 1;
                                dest_addr <= insDecode_ins[15:11];
                                imm <= op2;
                            end
                        end

                    endcase
                end

                `OP_SPECIAL2: begin
                    case(op3)
                        `OP_CLZ: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_CLZ;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                        end

                        `OP_CLO: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_CLO;
                            alusel_output <= `ALUSEL_ARCH;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 0;
                        end

                        `OP_MUL: begin
                            write_or_not <= 1;
                            aluop_output <= `ALUOP_MUL;
                            alusel_output <= `ALUSEL_MUL;
                            reg1_read_enabler <= 1;
                            reg2_read_enabler <= 1;
                        end
                    endcase
                end
            endcase
        end
    end

    always @ (*) begin
        if (rst == 1)
            in_delayslot_output <= 0;
        else
            in_delayslot_output <= in_delayslot;
    end


    always @ (*) begin
        if (rst == 1)
            regOp1 <= 0;
        else if (reg1_read_enabler == 1 && execute_WriteOrNot == 1 && execute_DestAddr == reg1_addr_output)
            regOp1 <= execute_Wdata;
        else if (reg1_read_enabler == 1 && memory_WriteOrNot == 1 && memory_DestAddr == reg1_addr_output)
            regOp1 <= memory_Wdata;
        else if (reg1_read_enabler == 1)
            regOp1 <= reg1_data_input;
        else 
            regOp1 <= imm;
    end

    always @ (*) begin
        if (rst == 1) 
            regOp2 <= 0;
        else if (reg2_read_enabler == 1 && execute_WriteOrNot == 1 && execute_DestAddr == reg2_addr_output)
            regOp2 <= execute_Wdata;
        else if (reg2_read_enabler == 1 && memory_WriteOrNot == 1 && memory_DestAddr == reg2_addr_output)
            regOp2 <= memory_Wdata;
        else if (reg2_read_enabler == 1) 
            regOp2 <= reg2_data_input;
        else 
            regOp2 <= imm;
    end
endmodule

