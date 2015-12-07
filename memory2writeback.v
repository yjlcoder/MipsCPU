`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:43 12/04/2015 
// Design Name: 
// Module Name:    memory2writeback 
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
module memory2writeback(
    input rst,
    input clk,
    input wire[4:0] dest_addr,
    input write_or_not,
    input wire[31:0] wdata,

    input memory_HILO_enabler,
    input wire[31:0] memory_HILO_HI,
    input wire[31:0] memory_HILO_LO,

    /* memory2writeback -> regfile */
    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,
    output reg[31:0] wdata_output,

    /* memory2writeback -> HILO */
    output reg memory2writeback_HILO_enabler,
    output reg[31:0] memory2writeback_HILO_HI,
    output reg[31:0] memory2writeback_HILO_LO
    );

    always @ (posedge clk) begin
        if (rst == 1) begin
            dest_addr_output <= 0;
            write_or_not_output <= 0;
            wdata_output <= 0;
            memory2writeback_HILO_enabler <= 0; 
            memory2writeback_HILO_HI <= 0; 
            memory2writeback_HILO_LO <= 0;
        end else begin
            dest_addr_output <= dest_addr;
            write_or_not_output <= write_or_not;
            wdata_output <= wdata;
            memory2writeback_HILO_enabler <= memory_HILO_enabler;
            memory2writeback_HILO_HI <= memory_HILO_HI;
            memory2writeback_HILO_LO <= memory_HILO_LO;
        end
    end


endmodule
