`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2020 02:13:22 PM
// Design Name: 
// Module Name: shift_register
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


module shift_lefter(input [31:0] in, output [31:0] out);
assign out = {in[30:0], 1'b0};

endmodule
