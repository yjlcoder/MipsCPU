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

//10_6
`define OP_NOP10_6 5'b00000
`define OP_SSNOP10_6 5'b00001

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

`define ALUOP_NOP 8'b0000_0000

/* alusel */
`define ALUSEL_LOGIC 3'b001
`define ALUSEL_SHIFT 3'b010
`define ALUSEL_MOVE 3'b011
`define ALUSEL_NOP 3'b000
