`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2020 04:01:34 PM
// Design Name: 
// Module Name: processor_tb
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


module processor_tb();
reg clk, rst;
// instantiate device under test
single_cycle_processor my_processor(.clk(clk), .rst(rst));

// apply clock
initial begin
clk = 0;
forever #50 clk = ~clk;
end
// apply inputs one at a time
// checking results
initial begin
// check that registers contents = 0 when rst = 1
$display("Start excuting");
// hex file import .mem
// 
//$readmemb 
rst = 1; 
#100
rst =0;
end
endmodule
