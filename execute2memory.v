`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:51 12/04/2015 
// Design Name: 
// Module Name:    execute2memory 
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
module execute2memory(
    input rst,
    input clk,
    input wire[4:0] dest_addr,
    input write_or_not,
    input wire[31:0] wdata,

    input execute_HILO_enabler,
    input wire[31:0] execute_HILO_HI,
    input wire[31:0] execute_HILO_LO,
    
    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,
    output reg[31:0] wdata_output,

    output reg execute2memory_HILO_enabler,
    output reg[31:0] execute2memory_HILO_HI,
    output reg[31:0] execute2memory_HILO_LO
    );

    always @ (posedge clk) begin
        if (rst == 1) begin
            dest_addr_output <= 0;
            write_or_not_output <= 0;
            wdata_output <= 0;
            execute2memory_HILO_enabler <= 0;
            execute2memory_HILO_HI <= 0;
            execute2memory_HILO_LO <= 0;
        end else begin
            dest_addr_output <= dest_addr;
            write_or_not_output <= write_or_not;
            wdata_output <= wdata;
            execute2memory_HILO_enabler <= execute_HILO_enabler;
            execute2memory_HILO_HI <= execute_HILO_HI;
            execute2memory_HILO_LO <= execute_HILO_LO;
        end
    end
endmodule
