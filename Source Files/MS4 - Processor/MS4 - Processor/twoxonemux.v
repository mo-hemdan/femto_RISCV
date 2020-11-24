`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2020 02:36:03 PM
// Design Name: 
// Module Name: twoxonemux
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


module twoxonemux (input w0, w1, s, output f);

assign f = s ? w1 : w0;
endmodule
