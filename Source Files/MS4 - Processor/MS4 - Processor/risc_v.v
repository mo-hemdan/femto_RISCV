`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/25/2020 01:14:51 PM
// Design Name: 
// Module Name: risc_v
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


module risc_v(
    input ssd_clk, 
    input uart_in,
	output [7:0] indicate_leds,
	output [7:0] status_leds,
	output [3:0] Anode,
	output [6:0] SSD_out
    );
	
	wire [7:0] uart_out; //7 -> a, 6 -> s ...
	wire rclk = uart_out[7];
	wire reset = uart_out[6];
	wire [1:0] ledSel = uart_out[5:4];
	wire [3:0] ssdSel = uart_out[3:0];
	assign indicate_leds = uart_out;
    UART_receiver_multiple_Keys risc_reciever(.clk(ssd_clk), .uart_in(uart_in), .out(uart_out));
	
	single_cycle_processor Rv_processor(.clk(rclk), .ssd_clk(ssd_clk), .rst(reset), .led_sel(ledSel), .ssd_sel(ssdSel), .anode(Anode), .SSD_out(SSD_out), .LED(status_leds));
	
endmodule
