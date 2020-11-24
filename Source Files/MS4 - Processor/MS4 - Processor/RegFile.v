module RegFile (input clk, rst, input [4:0] readreg1, readreg2, writereg, input [31:0] writedata,input regwrite, output [31:0] readdata1, readdata2 );
reg [31:0] load;
wire [31:0] out_t [0:31];
genvar i;
generate
for (i=0; i<32; i = i+1) 
  begin
    register_32 registers(.in(writedata), .clk(clk), .rst(rst), .load(load[i]), .out(out_t[i]));
  end
endgenerate
assign readdata1 =  out_t[readreg1];
assign readdata2 = out_t[readreg2];

assign out_t[0] = 0;

always @(*) begin
if (regwrite == 1'b1 && writereg != 0)
begin
load = 32'b00000000000000000000000000000000;
load [writereg] = 1'b1;
end
else
load = 32'b00000000000000000000000000000000;

end

endmodule