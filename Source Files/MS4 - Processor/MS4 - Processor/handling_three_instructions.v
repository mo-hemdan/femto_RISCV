`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2020 09:29:14 PM
// Design Name: 
// Module Name: handling_three_instructions
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


module handling_remaining_instructions(input [4:0] opcode, input distin, output[1:0] stall_stop);
reg [1:0] stall_t;
always @ (*)
  begin
    case (opcode)
    5'b00011 : stall_t = 2'b01; // stall program one nop, fence and fence i
    5'b11100 : 
      begin
        if (distin == 1)
          stall_t = 2'b10; //  stop the program entirely, for Ebreak
        else
          stall_t = 2'b01; // stop program one nop for Ecall
      end
    default: stall_t = 2'b00;
    endcase
  end
  assign stall_stop = stall_t; ///
endmodule