`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2020 03:39:46 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit (input [6:0] inst, output MemRead, MemtoReg, MemWrite,ALUsrc, RegWrite, output [1:0] ALUOp, output [1:0] Branch, output [1:0] RegSrc);
reg [1:0] brn;
assign Branch =brn;
assign RegSrc = (inst[6:2]==5'b00101)? 2'b10 : ((inst[6:2]==5'b11011|inst[6:2]==5'b11001) ? 2'b01 : 2'b00); // AUIPC takes 10, jal and jalr 01, input from alu 00
always @(*) begin
if (inst[6:2]==5'b11000) brn = 2'b10;
else if(inst[6:2]==5'b11001) brn = 2'b01;
else if (inst[6:2]==5'b11011) brn=2'b11;
else brn=2'b00;

end

//assign Branch = (inst[6:2]==5'b11000)? 2'b10 : ((inst[6:2]==5'b11001) ? 2'b01 : ((inst[6:2]==5'b11011)?2'b11: 2'b00)); // regular branch BEQ 10, jalr branch 01 don't branch 00 //11 for the jal instruction
assign MemRead = (inst[6:2]==5'b0000);    // no modification in mind
assign MemtoReg = (inst[6:2]==5'b00000); // no modification in mind
assign MemWrite = (inst[6:2]==5'b01000); // no modification in mind
assign ALUsrc = (inst[6:2]==5'b01000|inst[6:2]==5'b00000|inst[6:2]==5'b00100|inst[6:2]==5'b11001|inst[6:2]==5'b01101); //  supports arithmatic immediate and jalr and lui
assign RegWrite = (inst[6:2]==5'b01100|inst[6:2]==5'b00000|inst[6:2]==5'b00100|inst[6:2]==5'b11011|inst[6:2]==5'b11001|inst[6:2]==5'b01101|inst[6:2]==5'b00101); // supports jal and jalr and immediate arithmatic and lui and AUIPC
//assign ALUOp = (inst[6:2]==5'b01100|inst[6:2]==5'b00100) ? 2'b10 : ((inst[6:2]==5'b11000) ? 2'b01 : 2'b00); 
assign ALUOp = (inst[6:2]==5'b01100|inst[6:2]==5'b00100)? 2'b10 : ((inst[6:2]==5'b11000) ? 2'b01 : ((inst[6:2]==5'b01101)?2'b11: 2'b00));// support arithmatic immediate and  LUI
endmodule
