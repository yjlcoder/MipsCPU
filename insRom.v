`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:50 12/05/2015 
// Design Name: 
// Module Name:    insRom 
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
module instRom(
    input enabler,
    input wire[31:0] addr,
    output reg[31:0] inst
    );

    reg[31:0] instMem[0:255];

    initial $readmemh( "instRom.data", instMem );

    always @ (*) begin
        if (enabler == 0)
            inst <= 0;
        else
            inst <= instMem[addr[18:2]];
    end

endmodule
