`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:52 12/04/2015 
// Design Name: 
// Module Name:    regfile 
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
module regfile(
    input clk,
    input rst,

    input we,
    input wire[4:0] waddr,
    input wire[31:0] wdata,

    input re1,
    input wire[4:0] raddr1,
    output reg[31:0] rdata1,

    input re2,
    input wire[4:0] raddr2,
    output reg[31:0] rdata2
    );

    /* Define 32 x 32 regs */
    reg[31:0] regs[0:31];

    /* Wirte to waddr */
    always @ (posedge clk) begin
        if(rst == 0 && we == 1 && waddr != 0)
            regs[waddr] <= wdata;
    end

    /* Read from raddr1 */
    always @ (*) begin
        if(rst == 1)
            rdata1 <= 0;
        else if (raddr1 == 0)
            rdata1 <= 0;
        else if (raddr1 == waddr && we == 1 && re1 == 1)
            rdata1 <= wdata;
        else if (re1 == 1)
            rdata1 <= regs[raddr1];
        else
            rdata1 <= 0;
    end

    /* Read from raddr2 */
    always @ (*) begin
        if(rst == 1)
            rdata2 <= 0;
        else if (raddr2 == 0)
            rdata2 <= 0;
        else if (raddr2 == waddr && we == 1 && re1 == 1)
            rdata2 <= wdata;
        else if (re2 == 1)
            rdata2 <= regs[raddr2];
        else
            rdata2 <= 0;
    end

endmodule
