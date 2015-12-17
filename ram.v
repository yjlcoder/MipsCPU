`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:16 12/09/2015 
// Design Name: 
// Module Name:    ram 
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
module ram(
    input clk,
    input enabler,
    input write_enabler,
    input wire[31:0] addr,
    input wire[3:0] select,
    input wire[31:0] data_input,
    output reg[31:0] data_output,
    
    /* VGA */
    input wire[31:0] vga_raddr,
    output reg[31:0] vga_rdata,
    
    /* BTN */
    input wire[31:0] btn_data
    );

    reg[7:0] byte_mem0[0:1023];
    reg[7:0] byte_mem1[0:1023];
    reg[7:0] byte_mem2[0:1023];
    reg[7:0] byte_mem3[0:1023];

    reg[31:0] button_mem;

    always @ (posedge clk) begin
        if (enabler == 1 && write_enabler == 1) begin
            if (select[3] == 1) begin
                byte_mem3[addr[18:2]] <= data_input[31:24];
            end
            if (select[2] == 1) begin
                byte_mem2[addr[18:2]] <= data_input[23:16];
            end
            if (select[1] == 1) begin
                byte_mem1[addr[18:2]] <= data_input[15:8];
            end
            if (select[0] == 1) begin
                byte_mem0[addr[18:2]] <= data_input[7:0];
            end
        end

        button_mem <= btn_data;

        /*
        if(btn_enabler == 1 && btn_we == 1) begin
            if (btn_select[3] == 1) begin
                byte_mem3[btn_addr[18:2]] <= btn_data[7:0];
            end
            if (btn_select[2] == 1) begin
                byte_mem2[btn_addr[18:2]] <= btn_data[7:0];
            end
            if (btn_select[1] == 1) begin
                byte_mem1[btn_addr[18:2]] <= btn_data[7:0];
            end
            if (btn_select[0] == 1) begin
                byte_mem0[btn_addr[18:2]] <= btn_data[7:0];
            end
        end
        */
    end

    always @ (*) begin
        if (enabler == 0) begin
            data_output <= 0;
        end else if (addr[18:2] == 1024) begin
            data_output <= button_mem;
        end else if (write_enabler == 0) begin
            data_output <= {byte_mem3[addr[18:2]], byte_mem2[addr[18:2]], byte_mem1[addr[18:2]], byte_mem0[addr[18:2]]};
        end else begin
            data_output <= 0;
        end
    end

    always @ (*) begin
        vga_rdata <= {byte_mem3[vga_raddr[18:2]], byte_mem2[vga_raddr[18:2]], byte_mem1[vga_raddr[18:2]], byte_mem0[vga_raddr[18:2]]};
    end

endmodule
