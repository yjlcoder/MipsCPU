`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:05 12/04/2015 
// Design Name: 
// Module Name:    defineOperator 
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


/* operator */
// Ö¸ÁîÂë
`define OP_ORI 6'b001101
`define OP_ANDI 6'b001100
`define OP_XORI 6'b001110
`define OP_LUI 6'b001111
`define OP_SPECIAL 6'b000000
`define OP_SPECIAL2 6'b011100
`define OP_ADDI 6'b001000
`define OP_ADDIU 6'b001001
`define OP_SLTI 6'b001010
`define OP_SLTIU 6'b001011
`define OP_J 6'b000010
`define OP_JAL 6'b000011
`define OP_BEQ 6'b000100
`define OP_BGTZ 6'b000111
`define OP_BLEZ 6'b000110
`define OP_BNE 6'b000101
`define OP_LB 6'b100000
`define OP_LBU 6'b100100
`define OP_LH 6'b100001
`define OP_LHU 6'b100101
`define OP_LW 6'b100011
`define OP_SB 6'b101000
`define OP_SH 6'b101001
`define OP_SW 6'b101011
`define OP_LWL 6'b100010
`define OP_LWR 6'b100110

`define OP_REGIMM 6'b000001

//¹¦ÄÜÂë
//000000
`define OP_AND 6'b100100
`define OP_OR  6'b100101
`define OP_XOR 6'b100110
`define OP_NOR 6'b100111
`define OP_SRL 6'b000010
`define OP_SRA 6'b000011
`define OP_SLLV 6'b000100
`define OP_SRLV 6'b000110
`define OP_SRAV 6'b000111
`define OP_SYNC 6'b001111
`define OP_SLL 6'b000000
`define OP_NOP 6'b000000
`define OP_SSNOP 6'b000000

`define OP_MOVN 6'b001011
`define OP_MOVZ 6'b001010
`define OP_MFHI 6'b010000
`define OP_MFLO 6'b010010
`define OP_MTHI 6'b010001
`define OP_MTLO 6'b010011

`define OP_ADD 6'b100000
`define OP_ADDU 6'b100001
`define OP_SUB 6'b100010
`define OP_SUBU 6'b100011
`define OP_SLT 6'b101010
`define OP_SLTU 6'b101011
`define OP_MULT 6'b011000
`define OP_MULTU 6'b011001

`define OP_JR 6'b001000
`define OP_JALR 6'b001001

//011100
`define OP_CLZ 6'b100000
`define OP_CLO 6'b100001
`define OP_MUL 6'b000010

//10_6
`define OP_NOP10_6 5'b00000
`define OP_SSNOP10_6 5'b00001

//20_16
`define OP_BLTZ 5'b00000
`define OP_BLTZAL 5'b10000
`define OP_BGEZ 5'b00001
`define OP_BGEZAL 5'b10001

/* aluop */
`define ALUOP_AND 8'b0010_0100
`define ALUOP_OR 8'b0010_0101
`define ALUOP_XOR 8'b0010_0110
`define ALUOP_NOR 8'b0010_0111
`define ALUOP_ANDI 8'b0101_1001
`define ALUOP_ORI 8'b0101_1010
`define ALUOP_XORI 8'b0101_1011
`define ALUOP_LUI 8'b0101_1100
`define ALUOP_SLL 8'b0111_1100
`define ALUOP_SLLV 8'b0000_0100
`define ALUOP_SRL 8'b0000_0010
`define ALUOP_SRLV 8'b0000_0110
`define ALUOP_SRA 8'b0000_0011
`define ALUOP_SRAV 8'b0000_0111

`define ALUOP_MOVZ  8'b00001010
`define ALUOP_MOVN  8'b00001011
`define ALUOP_MFHI  8'b00010000
`define ALUOP_MTHI  8'b00010001
`define ALUOP_MFLO  8'b00010010
`define ALUOP_MTLO  8'b00010011

`define ALUOP_SLT  8'b00101010
`define ALUOP_SLTU  8'b00101011
`define ALUOP_SLTI  8'b01010111
`define ALUOP_SLTIU  8'b01011000   
`define ALUOP_ADD  8'b00100000
`define ALUOP_ADDU  8'b00100001
`define ALUOP_SUB  8'b00100010
`define ALUOP_SUBU  8'b00100011
`define ALUOP_ADDI  8'b01010101
`define ALUOP_ADDIU  8'b01010110
`define ALUOP_CLZ  8'b10110000
`define ALUOP_CLO  8'b10110001

`define ALUOP_MULT  8'b00011000
`define ALUOP_MULTU  8'b00011001
`define ALUOP_MUL  8'b10101001

`define ALUOP_J  8'b01001111
`define ALUOP_JAL  8'b01010000
`define ALUOP_JALR  8'b00001001
`define ALUOP_JR  8'b00001000
`define ALUOP_BEQ  8'b01010001
`define ALUOP_BGEZ  8'b01000001
`define ALUOP_BGEZAL  8'b01001011
`define ALUOP_BGTZ  8'b01010100
`define ALUOP_BLEZ  8'b01010011
`define ALUOP_BLTZ  8'b01000000
`define ALUOP_BLTZAL  8'b01001010
`define ALUOP_BNE  8'b01010010

`define ALUOP_NOP 8'b0000_0000

/* alusel */
`define ALUSEL_LOGIC 3'b001
`define ALUSEL_SHIFT 3'b010
`define ALUSEL_MOVE 3'b011
`define ALUSEL_ARCH 3'b100
`define ALUSEL_MUL 3'b101
`define ALUSEL_JUMP_BRANCH 3'b110
`define ALUSEL_NOP 3'b000
