`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:18:06 12/05/2015 
// Design Name: 
// Module Name:    cpu 
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
module cpu(
    input rst,
    input clk,
    input [4:0] btn,

    output [1:0] blue_out,
    output [2:0] red_out,
    output [2:0] green_out,
    output Hsync_out,
    output Vsync_out
    );

    wire[31:0] instAddr;
    wire[31:0] inst;

    wire[31:0] ram_data_input;
    wire[31:0] ram_addr_output;
    wire[31:0] ram_data_output;
    wire[3:0] ram_select_output;
    wire ram_write_enabler;

    wire clk0;
    wire clk_vga;

    wire[31:0] vga_raddr;
    wire[31:0] vga_rdata;

    clk_ip clk_ip0(
        .CLK_IN1(clk),
        .CLK_OUT1(clk0),
        .CLK_VGA(clk_vga),
        .RESET(1'b0)
    );

    //wire ram_enabler;

    mips mips0(
        .rst(rst), 
        .clk(clk0),
        .ins_input(inst),
        .addr_output(instAddr),

        .ram_data(ram_data_input),
        .ram_addr_output(ram_addr_output),
        .ram_write_enabler_output(ram_write_enabler),
        .ram_select_output(ram_select_output),
        .ram_data_output(ram_data_output),
        .ram_enabler(ram_enabler)
    );

    /*instRom instMem(
        .enabler(enabler),
        .a(instAddr),
        .spo(inst)
    );*/

    instMem_ip instMem(
        .a(instAddr[11:2]),
        .spo(inst)
    );

    ram ram0(
        .clk(clk0),
        .enabler(ram_enabler),
        .write_enabler(ram_write_enabler),
        .addr(ram_addr_output),
        .select(ram_select_output),
        .data_input(ram_data_output),
        .data_output(ram_data_input),
        .vga_raddr(vga_raddr),
        .vga_rdata(vga_rdata)
    );

    vga vga0(
        .clk50(clk_vga),
        .Hsync(Hsync_out),
        .Vsync(Vsync_out),
        .red_out(red_out),
        .blue_out(blue_out),
        .green_out(green_out),
        .raddr(vga_raddr),
        .rdata(vga_rdata)
    );

endmodule

