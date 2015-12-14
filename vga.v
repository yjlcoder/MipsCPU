`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:41:49 12/11/2015 
// Design Name: 
// Module Name:    vga 
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

module vga(
        input clk, rst,
        output Hsync, Vsync,
        output [2:0] vgaRed, vgaGreen,
        output [1:0] vgaBlue,
        input [31:0] point_in,
        input mark,
        input [31:0] mem,
        output [31:0] raddr
    );
    reg [8:0] posh, posv;
    reg [10:0] count_h, count_v, point;
	 initial begin
	   count_h <= 0;
		count_v <= 0;
	 end
    always @(negedge clk) 
        if (mark) point <= point_in[10:0];
		  
    always @(negedge clk or negedge rst)
        if (!rst)
            count_h <= 11'd0;
        else if (count_h == 11'd1056)
            count_h <= 11'd0;
        else
            count_h <= count_h + 1'b1;
    always @(negedge clk or negedge rst)
        if (!rst)
            count_v <= 11'd0;
        else if (count_v == 11'd625)
            count_v <= 11'd0;
        else if (count_h == 11'd1056)
            count_v <= count_v + 1'b1;
    reg isready;
	 always @(negedge clk or negedge rst)
		  if (!rst) begin
				posh <= 0;
				posv <= 0;
				isready <= 1'b0;
		  end else begin
				if ((count_h > 11'd384 && count_h < 11'd896) && (count_v > 11'd68 && count_v < 11'd580)) begin
					isready <= 1'b1;
					if (posh == 9'd510) posh <= 0; else posh <= posh + 1'b1;
					if (posv == 9'd511) begin
						posv <= 0;
					end else begin
						if (posh == 9'd510) posv <= posv + 1'b1;
					end
				end else begin
					isready <= 1'b0;
				end
		  end
	 assign raddr = {25'd0, posv[8:4], 2'd0};
	 assign vgaRed = (isready && !mem[posh[8:4]]) ? 3'b111 : 3'b000;
    assign vgaGreen = (isready && !mem[posh[8:4]] && (posv[8:4]!=point[9:5] || posh[8:4]!=point[4:0])) ? 3'b111 : 3'b000;
    assign vgaBlue = (isready && !mem[posh[8:4]] && (posv[8:4]!=point[9:5] || posh[8:4]!=point[4:0])) ? 2'b11 : 2'b00;
	 assign Hsync = (count_h <= 11'd80) ? 1'b0 : 1'b1;
    assign Vsync = (count_v <= 11'd3) ? 1'b0 : 1'b1;
endmodule

