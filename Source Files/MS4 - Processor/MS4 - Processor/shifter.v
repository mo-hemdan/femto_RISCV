`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2020 04:04:23 AM
// Design Name: 
// Module Name: shifter
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


module shifter(input [31:0] a, input [4:0] shamt, input [1:0] type,  output [31:0] r);

reg [31:0] aluresults [2:0];
reg [31:0] r_t;
assign r =r_t;
integer j;
always @(*) 
  begin // for the left shift register
    aluresults[0] = 0;
      for (j=0; j<32; j = j+1) 
        begin
          if (j+shamt <32)
            aluresults [0][j+shamt] = a[j];
        end
  end

integer k;
always @(*) begin // for the right shift register
for (k=0; k<32; k = k+1) 
  begin
    if (k+shamt< 32) 
      begin
        aluresults [1][k] = a[k+shamt]; // right shifting
        aluresults [2][k] = a[k+shamt]; // right shifting
      end
    else 
      begin
        if (a[31]==1'b1) 
          begin
            aluresults [1] [k] = 1'b0; // right shifting logical
            aluresults [2] [k] = 1'b1; // right shifting arithmatic
          end 
        else 
          begin
            aluresults [1] [k] = 1'b0;
            aluresults [2] [k] = 1'b0;
          end
      end
  end

end


always @(*) 
  begin
    case (type)
      2'b00 : r_t = aluresults[0];
      2'b01 : r_t = aluresults[1];
      2'b10 : r_t = aluresults[2];
    endcase
  end


endmodule
