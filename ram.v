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
    output reg[31:0] data_output
    );

    reg[7:0] byte_mem0[0:65565];
    reg[7:0] byte_mem1[0:65535];
    reg[7:0] byte_mem2[0:65535];
    reg[7:0] byte_mem3[0:65535];

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
    end

    always @ (*) begin
        if (enabler == 0) begin
            data_output <= 0;
        end else if (write_enabler == 0) begin
            data_output <= {byte_mem3[addr[18:2]], byte_mem2[addr[18:2]], byte_mem1[addr[18:2]], byte_mem0[addr[18:2]]};
        end else begin
            data_output <= 0;
        end
    end

endmodule
