`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2020 01:43:03 PM
// Design Name: 
// Module Name: mux_32
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


module bit_mux (input [31:0] w0, input [31:0] w1, input s, output [31:0] f);
genvar i;
generate 
 for (i = 0; i<32; i = i+1)
  begin 
    twoxonemux mux( .w0(w0[i]) , .w1(w1[i]) , .s(s), .f(f[i]));
  end
endgenerate

endmodule
