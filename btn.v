`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:01 12/16/2015 
// Design Name: 
// Module Name:    btn 
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
module btn_module(
    input clk,
    input wire[4:0] btn,
    output reg [31:0] wdata
    );

    always @ (posedge clk) begin
        if(btn == 1) begin
            wdata <= 1;
        end else if (btn == 2) begin
            wdata <= 2;
        end else if (btn == 4) begin
            wdata <= 3;
        end else if (btn == 8) begin
            wdata <= 4;
        end else if (btn == 16) begin
            wdata <= 5;
        end else begin
            wdata <= 0;
        end
    end
endmodule
