`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:54 12/06/2015 
// Design Name: 
// Module Name:    HILO 
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
module HILO(
    input clk,
    input rst,
    input enabler,
    input memory2writeback_HI,
    input memory2writeback_LO,

    output reg hilo_hi,
    output reg hilo_lo,
    );

    always (posedge clk) begin
        if(rst == 1) begin
            hilo_hi <= 0;
            hilo_lo <= 0;
        end else
            if (enabler == 1) begin
                hilo_hi <= memory2writeback_HI;
                hilo_lo <= memory2writeback_LO;
            end
        end
    end

endmodule
