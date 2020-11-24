`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2020 04:12:36 PM
// Design Name: 
// Module Name: ALUOp
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


module ALU_ctrl (
	input [1:0] aluOp, 
	input [2:0] inst_1,
	input inst_2,
	input inst_3,
	output reg [3:0] aluSel
	);
	
always @(*) begin
	case(aluOp)
		2'b00: aluSel = 4'b00_00;//ADD
		2'b01: aluSel = 4'b00_01;//SUB
		2'b11: aluSel= 4'b00_10;//LUI
		2'b10: begin
			case(inst_1)
				3'b000: 
				  begin
				    case(inst_3)//ADD
				        1'b1: 
				            begin
				                if(inst_2 == 1'b1)
				                   aluSel = 4'b00_01;//SUB
				                else 
				                   aluSel = 4'b00_00;//ADD
				             end
				        1'b0:  aluSel = 4'b00_00;//ADDI
				      endcase
				  end
				3'b111: aluSel = 4'b01_01;//AND
				3'b110:	aluSel = 4'b01_00;//OR	
				3'b100: aluSel = 4'b01_11;//XOR
				3'b101:
				  begin
				    if (inst_2 == 1) aluSel = 4'b10_10; //SRA
				    else aluSel = 4'b10_01; //SRL
				  end
				3'b001: aluSel = 4'b10_00;//SLL
				3'b010: aluSel = 4'b11_01;//SLT
				3'b011: aluSel = 4'b11_11;//SLTU
				default:aluSel = 4'b01_01;//ADD 		
			endcase
		end
	default :aluSel = 4'b00_01;//ADD 
	endcase	
end
endmodule
