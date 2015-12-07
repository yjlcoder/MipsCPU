`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:34:06 12/04/2015 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input rst,
    input clk,
    input wire[31:0] ins_input,
    output wire[31:0] addr_output,
    output enabler_output
    );


    /* PC -> insDecode */
    wire [31:0] pc;
    wire [31:0] insDecode_PC;
    wire [31:0] insDecode_Inst;


    /* insDecode -> insDecode2execute */
    wire [7:0] insDecode_AluopOutput;
    wire [2:0] insDecode_AluselOutput;
    wire [31:0] insDecode_Reg1;
    wire [31:0] insDecode_Reg2;
    wire [4:0] insDecode_DestAddr;
    wire insDecode_WriteOrNot;


    /* InsDecode -> Regfile & Regfile -> InsDecode*/
    wire reg1Enabler;
    wire reg2Enabler;
    wire [31:0] reg1Data;
    wire [31:0] reg2Data;
    wire [4:0] reg1Addr;
    wire [4:0] reg2Addr;
    
    /* InsDecode -> InsDecode2execute */
    wire [7:0] InsDecode_Aluop;
    wire [2:0] InsDecode_Alusel;
    wire [31:0] InsDecode_Reg1;
    wire [31:0] InsDecode_Reg2;
    wire [4:0]InsDecode_DestAddr;
    wire InsDecode_WriteOrNot;

    /* InsDecode2execute -> execute */
    wire [7:0] InsDecode2execute_aluop;
    wire [2:0] InsDecode2execute_alusel;
    wire [31:0] InsDecode2execute_Reg1;
    wire [31:0] InsDecode2execute_Reg2;
    wire InsDecode2execute_WriteOrNot;
    wire [4:0] InsDecode2execute_DestAddr;

    /* execute -> execute2memory */
    wire execute_WriteOrNot;
    wire [4:0] execute_DestAddr;
    wire [31:0] execute_Wdata;
    wire execute_HILO_enabler;
    wire [31:0]execute_HILO_HI;
    wire [31:0]execute_HILO_LO;

    /* execute2memory -> memory */
    wire execute2memory_WriteOrNot;
    wire [4:0] execute2memory_DestAddr;
    wire [31:0] execute2memory_Wdata;
    wire execute2memory_HILO_enabler;
    wire [31:0] execute2memory_HILO_HI;
    wire [31:0] execute2memory_HILO_LO;
    
    /* memory -> memory2writeback */
    wire memory_WriteOrNot;
    wire [4:0] memory_DestAddr;
    wire [31:0] memory_Wdata;
    wire memory_HILO_enabler;
    wire [31:0] memory_HILO_HI;
    wire [31:0] memory_HILO_LO;

    /* memory2writeback -> regfile */
    wire memory2writeback_WriteOrNot;
    wire [4:0] memory2writeback_DestAddr;
    wire [31:0] memory2writeback_Wdata;

    /* memory2writeback -> hilo & execute*/
    wire memory2writeback_HILO_enabler;
    wire [31:0] memory2writeback_HILO_HI;
    wire [31:0] memory2writeback_HILO_LO;

    /* hilo -> execute */
    wire [31:0] hilo_HI;
    wire [31:0] hilo_LO;

    assign addr_output = pc;

    pc_module pc_module0(
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .ce(enabler_output)
    );

    insFetch2insDecode insFecth2insDecode0(
        .clk(clk),.rst(rst),
        .insFetchPC(pc),.insFetchInst(ins_input),
        .insDecodePC(insDecode_PC), .insDecodeInst(insDecode_Inst)
    );

    insDecode insDecode0(
        .rst(rst),
        .insDecode_pc(insDecode_PC), .insDecode_ins(insDecode_Inst),
        .reg1_data_input(reg1Data), .reg2_data_input(reg2Data),
        .reg1_read_enabler(reg1Enabler), .reg2_read_enabler(reg2Enabler),
        .execute_WriteOrNot(execute_WriteOrNot), .execute_DestAddr(execute_DestAddr), .execute_Wdata,
        .memory_WriteOrNot(memory_WriteOrNot), .memory_DestAddr(memory_DestAddr), .memory_Wdata(memory_Wdata),
        .reg1_addr_output(reg1Addr), .reg2_addr_output(reg2Addr),
        .aluop_output(InsDecode_Aluop), .alusel_output(InsDecode_Alusel),
        .regOp1(InsDecode_Reg1), .regOp2(InsDecode_Reg2),
        .dest_addr(InsDecode_DestAddr), .write_or_not(InsDecode_WriteOrNot)
    );

    insDecode2execute insDecode2execute0(
        .clk(clk), .rst(rst),
        .aluop_input(InsDecode_Aluop), .alusel_input(InsDecode_Alusel),
        .regOp1(InsDecode_Reg1), .regOp2(InsDecode_Reg2),
        .dest_addr(InsDecode_DestAddr), .write_or_not(InsDecode_WriteOrNot),
        .aluop_output(InsDecode2execute_aluop), .alusel_output(InsDecode2execute_alusel),
        .regOp1_output(InsDecode2execute_Reg1), .regOp2_output(InsDecode2execute_Reg2),
        .dest_addr_output(InsDecode2execute_DestAddr), .write_or_not_output(InsDecode2execute_WriteOrNot)
    );

    execute execute0(
        .rst(rst),
        .aluop_input(InsDecode2execute_aluop), .alusel_input(InsDecode2execute_alusel),
        .regOp1(InsDecode2execute_Reg1), .regOp2(InsDecode2execute_Reg2),
        .dest_addr(InsDecode2execute_DestAddr), .write_or_not(InsDecode2execute_WriteOrNot),
        .memory_HILO_enabler(memory_HILO_enabler), .memory_HILO_HI(memory_HILO_HI), .memory_HILO_LO(memory_HILO_LO),
        .memory2writeback_HILO_enabler(memory2writeback_HILO_enabler),
        .memory2writeback_HILO_HI(memory2writeback_HILO_HI),
        .memory2writeback_HILO_LO(memory2writeback_HILO_LO),
        .dest_addr_output(execute_DestAddr), .write_or_not_output(execute_WriteOrNot),
        .wdata_output(execute_Wdata),
        .execute_HILO_enabler(execute_HILO_enabler),.execute_HILO_HI(execute_HILO_HI), .execute_HILO_LO(execute_HILO_LO)
    );

    execute2memory execute2memory0(
        .rst(rst), .clk(clk),
        .dest_addr(execute_DestAddr), .write_or_not(execute_WriteOrNot),
        .wdata(execute_Wdata),
        .execute_HILO_enabler(execute_HILO_enabler),
        .execute_HILO_HI(execute_HILO_HI),
        .execute_HILO_LO(execute_HILO_LO),
        .dest_addr_output(execute2memory_DestAddr), .write_or_not_output(execute2memory_WriteOrNot),
        .wdata_output(execute2memory_Wdata),
        .execute2memory_HILO_enabler(execute2memory_HILO_enabler),
        .execute2memory_HILO_HI(execute2memory_HILO_HI),
        .execute2memory_HILO_LO(execute2memory_HILO_LO)
    );

    memory memory0(
        .rst(rst),
        .dest_addr(execute2memory_DestAddr), .write_or_not(execute2memory_WriteOrNot),
        .wdata(execute2memory_Wdata),
        .execute2memory_HILO_enabler(execute2memory_HILO_enabler),
        .execute2memory_HILO_HI(execute2memory_HILO_HI),
        .execute2memory_HILO_LO(execute2memory_HILO_LO),
        .dest_addr_output(memory_DestAddr), .write_or_not_output(memory_WriteOrNot),
        .wdata_output(memory_Wdata),
        .memory_HILO_enabler(memory_HILO_enabler),
        .memory_HILO_HI(memory_HILO_HI),
        .memory_HILO_LO(memory_HILO_LO)
    );

    memory2writeback memory2writeback0(
        .clk(clk), .rst(rst),
        .dest_addr(memory_DestAddr), .write_or_not(memory_WriteOrNot),
        .wdata(memory_Wdata),
        .memory_HILO_enabler(memory_HILO_enabler),
        .memory_HILO_HI(memory_HILO_HI),
        .memory_HILO_LO(memory_HILO_LO),
        .dest_addr_output(memory2writeback_DestAddr), .write_or_not_output(memory2writeback_WriteOrNot),
        .wdata_output(memory2writeback_Wdata),
        .memory2writeback_HILO_enabler(memory2writeback_HILO_enabler),
        .memory2writeback_HILO_HI(memory2writeback_HILO_HI),
        .memory2writeback_HILO_LO(memory2writeback_HILO_LO)
    );

    regfile regfile0(
        .clk(clk), .rst(rst),
        .we(memory2writeback_WriteOrNot), .waddr(memory2writeback_DestAddr), .wdata(memory2writeback_Wdata),
        .re1(reg1Enabler), .re2(reg2Enabler),
        .raddr1(reg1Addr), .raddr2(reg2Addr),
        .rdata1(reg1Data), .rdata2(reg2Data)
    );

    hilo hilo0(
        .clk(clk), .rst(rst),
        .enabler(memory2writeback_HILO_enabler),
        .memory2writeback_HI(memory2writeback_HILO_HI), .memory2writeback_LO(memory2writeback_HILO_LO),
        .hilo_hi(hilo_HI), .hilo_lo(hilo_LO)
    );

endmodule
