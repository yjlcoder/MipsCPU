`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:48 12/11/2015 
// Design Name: 
// Module Name:    control 
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
module control(
    /*
    * control_output[5] -> writeback 
    * control_output[4] -> memory
    * control_output[3] -> execute
    * control_output[2] -> insDecode
    * control_output[1] -> insFetch
    * control_output[0] -> PC 
    */ 
    input rst,
    input insDecode_pause,
    input execute_pause,
    output reg[5:0] control_output
    );

    always @ (*) begin
        if(rst == 1) begin
            control_output <= 0;
        end else if(execute_pause == 1)
            control_output <= 6'b001111;
        else if(insDecode_pause == 1)
            control_output <= 6'b000111;
    end

endmodule
