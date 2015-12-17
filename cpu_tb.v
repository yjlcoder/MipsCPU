`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:25:48 12/15/2015
// Design Name:   cpu
// Module Name:   E:/HDL/MipsCPU/cpu_tb.v
// Project Name:  MipsCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

	// Inputs
	reg rst;
	reg clk;
	reg [4:0] btn;

	// Outputs
	wire [1:0] blue_out;
	wire [2:0] red_out;
	wire [2:0] green_out;
	wire Hsync_out;
	wire Vsync_out;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk), 
		.btn(btn), 
		.blue_out(blue_out), 
		.red_out(red_out), 
		.green_out(green_out), 
		.Hsync_out(Hsync_out), 
		.Vsync_out(Vsync_out)
	);

    integer file_output;
    integer counter;

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		btn = 0;
     //   file_output = $fopen("result.txt");

		// Wait 100 ns for global reset to finish
		#500;
        rst = 0;

        #1000 btn = 0;

        #500000 btn = 8;

        #1000 btn = 0;

        #500000 btn = 8;

        #1000 btn = 0;

        #10000000 $stop;
        
		// Add stimulus here

	end

    always #10 clk = ~clk;
    /*

    always @ (posedge clk) begin
        counter = counter + 1;

        $fdisplay(file_output, "regfiles0 = %h", cpu_tb.uut.mips0.regfile0.regs[0]);
        $fdisplay(file_output, "regfiles1 = %h", cpu_tb.uut.mips0.regfile0.regs[1]);
        $fdisplay(file_output, "regfiles2 = %h", cpu_tb.uut.mips0.regfile0.regs[2]);
        $fdisplay(file_output, "regfiles3 = %h", cpu_tb.uut.mips0.regfile0.regs[3]);
        $fdisplay(file_output, "regfiles4 = %h", cpu_tb.uut.mips0.regfile0.regs[4]);
        $fdisplay(file_output, "regfiles5 = %h", cpu_tb.uut.mips0.regfile0.regs[5]);
        $fdisplay(file_output, "regfiles6 = %h", cpu_tb.uut.mips0.regfile0.regs[6]);
        $fdisplay(file_output, "regfiles7 = %h", cpu_tb.uut.mips0.regfile0.regs[7]);
        $fdisplay(file_output, "regfiles8 = %h", cpu_tb.uut.mips0.regfile0.regs[8]);
        $fdisplay(file_output, "regfiles9 = %h", cpu_tb.uut.mips0.regfile0.regs[9]);
        $fdisplay(file_output, "regfiles10 = %h", cpu_tb.uut.mips0.regfile0.regs[10]);
        $fdisplay(file_output, "regfiles11 = %h", cpu_tb.uut.mips0.regfile0.regs[11]);
        $fdisplay(file_output, "regfiles12 = %h", cpu_tb.uut.mips0.regfile0.regs[12]);
        $fdisplay(file_output, "regfiles13 = %h", cpu_tb.uut.mips0.regfile0.regs[13]);
        $fdisplay(file_output, "regfiles14 = %h", cpu_tb.uut.mips0.regfile0.regs[14]);
        $fdisplay(file_output, "regfiles15 = %h", cpu_tb.uut.mips0.regfile0.regs[15]);
        $fdisplay(file_output, "regfiles16 = %h", cpu_tb.uut.mips0.regfile0.regs[16]);
        $fdisplay(file_output, "regfiles17 = %h", cpu_tb.uut.mips0.regfile0.regs[17]);
        $fdisplay(file_output, "regfiles18 = %h", cpu_tb.uut.mips0.regfile0.regs[18]);
        $fdisplay(file_output, "regfiles19 = %h", cpu_tb.uut.mips0.regfile0.regs[19]);
        $fdisplay(file_output, "regfiles20 = %h", cpu_tb.uut.mips0.regfile0.regs[20]);
        $fdisplay(file_output, "regfiles21 = %h", cpu_tb.uut.mips0.regfile0.regs[21]);
        $fdisplay(file_output, "regfiles22 = %h", cpu_tb.uut.mips0.regfile0.regs[22]);
        $fdisplay(file_output, "regfiles23 = %h", cpu_tb.uut.mips0.regfile0.regs[23]);
        $fdisplay(file_output, "regfiles24 = %h", cpu_tb.uut.mips0.regfile0.regs[24]);
        $fdisplay(file_output, "regfiles25 = %h", cpu_tb.uut.mips0.regfile0.regs[25]);
        $fdisplay(file_output, "regfiles26 = %h", cpu_tb.uut.mips0.regfile0.regs[26]);
        $fdisplay(file_output, "regfiles27 = %h", cpu_tb.uut.mips0.regfile0.regs[27]);
        $fdisplay(file_output, "regfiles28 = %h", cpu_tb.uut.mips0.regfile0.regs[28]);
        $fdisplay(file_output, "regfiles29 = %h", cpu_tb.uut.mips0.regfile0.regs[29]);
        $fdisplay(file_output, "regfiles30 = %h", cpu_tb.uut.mips0.regfile0.regs[30]);
        $fdisplay(file_output, "regfiles31 = %h", cpu_tb.uut.mips0.regfile0.regs[31]);
        $fdisplay(file_output, "instr = %h", cpu_tb.uut.instMem.spo);
        $fdisplay(file_output, "pc = %h", cpu_tb.uut.instMem.a);
    end
    */
endmodule

