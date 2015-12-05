`timescale 1ns / 1ps
`include "defineOperator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:23 12/04/2015 
// Design Name: 
// Module Name:    execute 
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
module execute(
    input rst,
    input wire[7:0] aluop_input,
    input wire[2:0] alusel_input,
    input wire[31:0] regOp1,
    input wire[31:0] regOp2,
    input wire[4:0] dest_addr,
    input write_or_not,

    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,
    output reg[31:0] wdata_output
    );

    reg [31:0] opOut;

    always @ (*) begin
        if(rst == 1) begin
            opOut <= 0;
        end else begin
            case (aluop_input)
                `ALUOP_OR: begin
                    opOut <= regOp1 | regOp2;
                end
                default:
                    opOut <= 0;
            endcase
        end
    end

    always @ (*) begin
        dest_addr_output <= dest_addr;
        write_or_not_output <= write_or_not;
        case (alusel_input)
            `ALUSEL_LOGIC:
                wdata_output <= opOut;
            default:
                wdata_output <= 0;
        endcase
    end
endmodule
