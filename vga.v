`timescale 1ns / 1ps

module vsync(line_clk, vsync_out, posY);
   input line_clk;
   output vsync_out;
   output wire[10:0] posY;
   
   reg [10:0] count = 0;
   reg vsync  = 0;

   always @(posedge line_clk)
	 if (count < 666)
	   count <= count + 1;
	 else
	   count <= 0;
      
   always @(posedge line_clk)
	 begin
		if (count < 637)
		  vsync 	<= 1;
		else if (count >= 637 && count < 643)
		  vsync 	<= 0;
		else if (count >= 643)
		  vsync 	<= 1;
	 end

   assign vsync_out  = vsync;
   assign posY = count;
   
endmodule // hsync   

module hsync(clk50, hsync_out, newline_out, posX);
   input clk50;
   output hsync_out, newline_out;
   output wire[10:0] posX;
   
   reg [10:0] count = 0;
   reg hsync 	= 0;
   reg newline 	= 0;

   always @(posedge clk50)
	 begin
		if (count < 1040)
		  count  <= count + 1;
		else
		  count  <= 0;
	 end
   
   always @(posedge clk50)
	 begin
		if (count == 0)
		  newline <= 1;
		else
		  newline <= 0;
	 end

   always @(posedge clk50)
	 begin
		if (count < 856) // pixel data plus front porch
		  hsync <= 1;
		else if (count >= 856 && count < 976)
		  hsync <= 0;
		else if (count >= 976)
		  hsync <= 1;
	 end // always @ (posedge clk50)
				 
   assign hsync_out    = hsync;
   assign newline_out  = newline;
   assign posX = count;
   
endmodule // hsync

module vga(clk50, Hsync, Vsync, red_out, blue_out, green_out, raddr, rdata);
   input clk50;
   input wire[31:0] rdata;
   output Hsync, Vsync;
   output wire[2:0] red_out, green_out;
   output wire[1:0] blue_out;
   output wire[31:0] raddr;
   wire line_clk;
   wire clk50;
   wire [10:0] posY;
   wire [10:0] posX;
   //assign {red_out[2], green_out[2], red_out[1], green_out[1], blue_out[1], red_out[0], green_out[0], blue_out[0]} = (posX * posY);

   assign raddr = 32'h400 + (posY/27) * 37 + (posX / 37);
   assign {red_out, green_out, blue_out} = raddr[1:0] == 2'b00 ? rdata[7:0] : raddr[1:0] == 2'b01 ? rdata[15:8] : raddr[1:0] == 2'b10 ? rdata[23:16] : rdata[31:24];

   hsync   hs(
       .clk50(clk50),
       .hsync_out(Hsync),
       .newline_out(line_clk),
       .posX(posX)
   );

   vsync   vs(
       .line_clk(line_clk),
       .vsync_out(Vsync),
       .posY(posY)
   );
endmodule // top
