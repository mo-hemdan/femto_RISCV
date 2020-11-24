`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2020 02:32:22 PM
// Design Name: 
// Module Name: immediate_generator
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

`include "defines.v"

module immediate_generator (input [31:0] inst, output reg [31:0] gen_out);
always @(*) begin
	case (inst[6:2])
		`OPCODE_Arith_I   : 	gen_out = { {21{inst[31]}}, inst[30:25], inst[24:21], inst[20] };
		`OPCODE_Store     :     gen_out = { {21{inst[31]}}, inst[30:25], inst[11:8], inst[7] };
		`OPCODE_LUI       :     gen_out = { inst[31], inst[30:20], inst[19:12], 12'b0 };
		`OPCODE_AUIPC     :     gen_out = { inst[31], inst[30:20], inst[19:12], 12'b0 };
		`OPCODE_JAL       : 	gen_out = { {12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0 };
		`OPCODE_JALR      : 	gen_out = { {21{inst[31]}}, inst[30:25], inst[24:21], inst[20] };
		`OPCODE_Branch    : 	gen_out = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
		default           : 	gen_out = { {21{inst[31]}}, inst[30:25], inst[24:21], inst[20] }; // IMM_I
	endcase 
end

endmodule