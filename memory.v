`timescale 1ns / 1ps
`include "defineOperator.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20:24:21 12/04/2015 
// Design Name: 
// Module Name: memory 
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
module memory(
    input rst,
    input wire[4:0] dest_addr,
    input write_or_not,
    input wire[31:0] wdata,

    input execute2memory_HILO_enabler,
    input wire[31:0] execute2memory_HILO_HI,
    input wire[31:0] execute2memory_HILO_LO,

    output reg[4:0] dest_addr_output,
    output reg write_or_not_output,
    output reg[31:0] wdata_output,

    output reg memory_HILO_enabler,
    output reg[31:0] memory_HILO_HI,
    output reg[31:0] memory_HILO_LO,

    input wire[7:0] aluop,
    input wire[31:0] mem_addr,
    input wire[31:0] regOp2,
    input wire[31:0] mem_data,
    output reg[31:0] mem_addr_output,
    output reg[31:0] mem_data_output,
    output reg mem_write_enabler_output,
    output reg[3:0] mem_select_output,
    output reg mem_enabler_output
    );

    always @ (*) begin
        if (rst == 1) begin
            dest_addr_output <= 0;
            write_or_not_output <= 0;
            wdata_output <= 0;
            memory_HILO_enabler <= 0;
            memory_HILO_HI <= 0;
            memory_HILO_LO <= 0;
        end else begin
            dest_addr_output <= dest_addr;
            write_or_not_output <= write_or_not;
            wdata_output <= wdata;
            memory_HILO_enabler <= execute2memory_HILO_enabler;
            memory_HILO_HI <= execute2memory_HILO_HI;
            memory_HILO_LO <= execute2memory_HILO_LO;
            mem_write_enabler_output <= 0;
            mem_addr_output <= 0;
            mem_select_output <= 4'b1111;
            mem_enabler_output <= 0;
            case (aluop)
                `ALUOP_LB: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 0;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            wdata_output <= {{24{mem_data[31]}},mem_data[31:24]};
                            mem_select_output <= 4'b1000;
                        end
                        2'b01: begin
                            wdata_output <= {{24{mem_data[23]}},mem_data[23:16]};
                            mem_select_output <= 4'b0100;
                        end
                        2'b10: begin
                            wdata_output <= {{24{mem_data[15]}},mem_data[15:8]};
                            mem_select_output <= 4'b0010;
                        end
                        2'b11: begin
                            wdata_output <= {{24{mem_data[7]}},mem_data[7:0]};
                            mem_select_output <= 4'b0001;
                        end
                        default: begin
                            wdata_output <= 0;
                        end
                    endcase
                end
                `ALUOP_LBU: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 0;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            wdata_output <= {{24{1'b0}},mem_data[31:24]};
                            mem_select_output <= 4'b1000;
                        end
                        2'b01: begin
                            wdata_output <= {{24{1'b0}},mem_data[23:16]};
                            mem_select_output <= 4'b0100;
                        end
                        2'b10: begin
                            wdata_output <= {{24{1'b0}},mem_data[15:8]};
                            mem_select_output <= 4'b0010;
                        end
                        2'b11: begin
                            wdata_output <= {{24{1'b0}},mem_data[7:0]};
                            mem_select_output <= 4'b0001;
                        end
                        default: begin
                            wdata_output <= 0;
                        end
                    endcase                
                end
                `ALUOP_LH: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 0;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            wdata_output <= {{16{mem_data[31]}},mem_data[31:16]};
                            mem_select_output <= 4'b1100;
                        end
                        2'b10: begin
                            wdata_output <= {{16{mem_data[15]}},mem_data[15:0]};
                            mem_select_output <= 4'b0011;
                        end
                        default: begin
                            wdata_output <= 0;
                        end
                    endcase                    
                end
                `ALUOP_LHU: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 0;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            wdata_output <= {{16{1'b0}},mem_data[31:16]};
                            mem_select_output <= 4'b1100;
                        end
                        2'b10: begin
                            wdata_output <= {{16{1'b0}},mem_data[15:0]};
                            mem_select_output <= 4'b0011;
                        end
                        default: begin
                            wdata_output <= 0;
                        end
                    endcase                
                end
                `ALUOP_LW: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 0;
                    wdata_output <= mem_data;
                    mem_select_output <= 4'b1111;
                    mem_enabler_output <= 1;        
                end
                `ALUOP_LWL: begin
                    mem_addr_output <= {mem_addr[31:2], 2'b00};
                    mem_write_enabler_output <= 0;
                    mem_select_output <= 4'b1111;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            wdata_output <= mem_data[31:0];
                        end
                        2'b01: begin
                            wdata_output <= {mem_data[23:0],regOp2[7:0]};
                        end
                        2'b10: begin
                            wdata_output <= {mem_data[15:0],regOp2[15:0]};
                        end
                        2'b11: begin
                            wdata_output <= {mem_data[7:0],regOp2[23:0]};    
                        end
                        default: begin
                            wdata_output <= 0;
                        end
                    endcase                
                end
                `ALUOP_LWR: begin
                    mem_addr_output <= {mem_addr[31:2], 2'b00};
                    mem_write_enabler_output <= 0;
                    mem_select_output <= 4'b1111;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            wdata_output <= {regOp2[31:8],mem_data[31:24]};
                        end
                        2'b01: begin
                            wdata_output <= {regOp2[31:16],mem_data[31:16]};
                        end
                        2'b10: begin
                            wdata_output <= {regOp2[31:24],mem_data[31:8]};
                        end
                        2'b11: begin
                            wdata_output <= mem_data;    
                        end
                        default: begin
                            wdata_output <= 0;
                        end
                    endcase                    
                end
                `ALUOP_SB: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 1;
                    mem_data_output <= {regOp2[7:0],regOp2[7:0],regOp2[7:0],regOp2[7:0]};
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            mem_select_output <= 4'b1000;
                        end
                        2'b01: begin
                            mem_select_output <= 4'b0100;
                        end
                        2'b10: begin
                            mem_select_output <= 4'b0010;
                        end
                        2'b11: begin
                            mem_select_output <= 4'b0001;    
                        end
                        default: begin
                            mem_select_output <= 4'b0000;
                        end
                    endcase                
                end
                `ALUOP_SH: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 1;
                    mem_data_output <= {regOp2[15:0],regOp2[15:0]};
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin
                            mem_select_output <= 4'b1100;
                        end
                        2'b10: begin
                            mem_select_output <= 4'b0011;
                        end
                        default: begin
                            mem_select_output <= 4'b0000;
                        end
                    endcase                        
                end
                `ALUOP_SW: begin
                    mem_addr_output <= mem_addr;
                    mem_write_enabler_output <= 1;
                    mem_data_output <= regOp2;
                    mem_select_output <= 4'b1111;    
                    mem_enabler_output <= 1;        
                end
                `ALUOP_SWL: begin
                    mem_addr_output <= {mem_addr[31:2], 2'b00};
                    mem_write_enabler_output <= 1;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin                          
                            mem_select_output <= 4'b1111;
                            mem_data_output <= regOp2;
                        end
                        2'b01: begin
                            mem_select_output <= 4'b0111;
                            mem_data_output <= {8'b00000000,regOp2[31:8]};
                        end
                        2'b10: begin
                            mem_select_output <= 4'b0011;
                            mem_data_output <= {16'b0000000000000000,regOp2[31:16]};
                        end
                        2'b11: begin
                            mem_select_output <= 4'b0001;    
                            mem_data_output <= {24'b000000000000000000000000,regOp2[31:24]};
                        end
                        default: begin
                            mem_select_output <= 4'b0000;
                        end
                    endcase                            
                end
                `ALUOP_SWR: begin
                    mem_addr_output <= {mem_addr[31:2], 2'b00};
                    mem_write_enabler_output <= 1;
                    mem_enabler_output <= 1;
                    case (mem_addr[1:0])
                        2'b00: begin                          
                            mem_select_output <= 4'b1000;
                            mem_data_output <= {regOp2[7:0],24'b000000000000000000000000};
                        end
                        2'b01: begin
                            mem_select_output <= 4'b1100;
                            mem_data_output <= {regOp2[15:0],16'b0000000000000000};
                        end
                        2'b10: begin
                            mem_select_output <= 4'b1110;
                            mem_data_output <= {regOp2[23:0],8'b00000000};
                        end
                        2'b11: begin
                            mem_select_output <= 4'b1111;    
                            mem_data_output <= regOp2[31:0];
                        end
                        default: begin
                            mem_select_output <= 4'b0000;
                        end
                    endcase                                            
                end
            endcase
        end
    end
endmodule
