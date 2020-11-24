`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2020 01:38:39 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit (
	input [4:0] ID_EX_rs1, 
	input [4:0] ID_EX_rs2, 
	input [4:0] EX_MEM_rd,
	input [4:0] MEM_WB_rd,
	input EX_MEM_RegWrite,
	input MEM_WB_RegWrite,
	output reg [1:0] forwardA, 
	output reg [1:0] forwardB
	);
	
	always @(*) begin
		//EX Hazard
			if(EX_MEM_RegWrite & (EX_MEM_rd != 0) &EX_MEM_rd == ID_EX_rs1) forwardA = 2'b10;
			else if(EX_MEM_RegWrite & (EX_MEM_rd != 0) & EX_MEM_rd == ID_EX_rs2) forwardB = 2'b10;
	
		
		//MEM Hazard
			else if(MEM_WB_RegWrite & (MEM_WB_rd != 0) & (MEM_WB_rd == ID_EX_rs1) & (!( EX_MEM_RegWrite & (EX_MEM_rd != 0) & (EX_MEM_rd == ID_EX_rs1) ))) forwardA = 2'b01;
			else if(MEM_WB_RegWrite & (MEM_WB_rd != 0) & (MEM_WB_rd == ID_EX_rs2) & (!( EX_MEM_RegWrite & (EX_MEM_rd != 0) & (EX_MEM_rd == ID_EX_rs2) ))) forwardB = 2'b01;
				else begin
            forwardA = 2'b00;
            forwardB = 2'b00;
        end
	end
endmodule
