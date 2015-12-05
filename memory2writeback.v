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
    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,
    output reg[31:0] wdata_output
    );

    always @ (posedge clk) begin
        if (rst == 1) begin
            dest_addr_output <= 0;
            write_or_not_output <= 0;
            wdata_output <= 0;
        end else begin
            dest_addr_output <= dest_addr;
            write_or_not_output <= write_or_not;
            wdata_output <= wdata;
        end
    end


endmodule
