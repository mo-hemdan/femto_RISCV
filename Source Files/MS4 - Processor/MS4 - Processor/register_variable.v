`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2020 02:31:33 PM
// Design Name: 
// Module Name: register_variable
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


module register_32_variable #(parameter N = 15)(input [N:0] in, input clk, input rst,input load, output [N:0] out);
wire f[N:0];
genvar i;
generate
for (i=0; i<N+1; i = i+1) 
  begin
    twoxonemux mux (.w0(out[i]), .w1(in[i]), .s(load), .f(f[i]));
    DFlipFlop flipflop (.clk(clk), .rst(rst), .D(f[i]), .Q(out[i]));
  end
endgenerate

endmodule
