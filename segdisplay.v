`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 12/10/2015 
// Design Name: 
// Module Name:    segdisplay 
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

module segClk(
	input wire clk,		//master clock: 50MHz
	input wire clr,		//asynchronous reset
	output wire segclk	//7-segment clock: 381.47Hz
	);

// 17-bit counter variable
reg [16:0] q;

// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge clk or posedge clr)
begin
	// reset condition
	if (clr == 1)
		q <= 0;
	// increment counter by one
	else
		q <= q + 1;
end

// 50Mhz ?2^17 = 381.47Hz
assign segclk = q[16];

// 50Mhz ?2^1 = 25MHz

endmodule

module segdisplay(
	input wire segclk,		//7-segment clock
	input wire clr,			//asynchronous reset
	output reg [6:0] seg,	//7-segment display LEDs
	output reg [3:0] an,		//7-segment display anode enable
    output dp
	);

// constants for displaying letters on display
parameter empty = 7'b1111111;
parameter L = 7'b1000111;
parameter Y = 7'b0010001;
parameter one = 7'b1111001;
parameter three = 7'b0110000;
parameter five = 7'b0010010;
parameter two = 7'b0100100;
parameter four = 7'b0011001;

// Finite State Machine (FSM) states
parameter left = 2'b00;
parameter midleft = 2'b01;
parameter midright = 2'b10;
parameter right = 2'b11;

// state register
reg [1:0] state;
assign dp = 1;
integer i;

// FSM which cycles though every digit of the display every 2.62ms.
// This should be fast enough to trick our eyes into seeing that
// all four digits are on display at the same time.
always @(posedge segclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		seg <= 7'b1111111;
		an <= 7'b1111;
		state <= left;
	end
	// display the character for the current position
	// and then move to the next state
	else
	begin
        i <= 4;
		case(state)
			left:
			begin
                seg <= empty;
				an <= 4'b0111;
				state <= midleft;
			end
			midleft:
			begin
                seg <= empty;
				an <= 4'b1011;
				state <= midright;
			end
			midright:
			begin
                seg <= L;
				an <= 4'b1101;
				state <= right;
			end
			right:
			begin
                seg <= Y;
				an <= 4'b1110;
				state <= left;
			end
		endcase
	end
end

endmodule

module segtop(
    input clk50,
    input rst,
    output [6:0] seg,
    output [3:0] an,
    output dp
);

wire segclk;

segClk segClk0(
    .clk(clk50),
    .clr(rst),
    .segclk(segclk)
);

segdisplay(
    .segclk(segclk),
    .clr(rst),
    .seg(seg),
    .an(an),
    .dp(dp)
);

endmodule
