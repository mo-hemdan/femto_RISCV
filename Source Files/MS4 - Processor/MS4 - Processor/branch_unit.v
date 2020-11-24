`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2020 04:47:36 AM
// Design Name: 
// Module Name: branch_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//branch_sel == 00 --> pc_4
//branch_sel == 10 --> branching conditions
//branch_sel == 01 --> JALR branching
//branch
//pc_4 --> branch_f = 00 
//pc_branch --> branch_f = 10
//ALU_result --> branch_f = 01

module branch_ctrl (
	input wire cf, zf, vf, sf,
	input [1:0] branch_sel,
	input [2:0] funct3,
	output reg [1:0] branch_f
	);
	always @(*) begin
	   if(branch_sel == 2'b10) begin
		case(funct3)
			3'b000: branch_f[1] = zf;      //branch if equal
			3'b001: branch_f[1] = (~zf);   //branch if not equal
			3'b100: branch_f[1] = (sf != vf); //branch if less than
			3'b110: branch_f[1] = (~cf);  //branch if less than unsigned
			3'b101: branch_f[1] = (sf == vf); //branch if greater than
			3'b111: branch_f[1] = (cf);//branch if greater than unsigned
			default: branch_f[1] = 1'b0;    //don't branch 
		endcase
		branch_f[0] = 1'b0;
		end
		else if(branch_sel == 2'b11) branch_f = 2'b10; 
		else begin branch_f = branch_sel; end
	end
//////////////////////************************////////////////////
endmodule
