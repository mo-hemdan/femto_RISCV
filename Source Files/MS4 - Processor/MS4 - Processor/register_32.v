module register_32 (input [31:0] in, input clk, input rst, input load, output [31:0] out);
wire f[31:0];
genvar i;
generate
for (i=0; i<32; i = i+1) 
  begin
    twoxonemux mux (.w0(out[i]), .w1(in[i]), .s(load), .f(f[i]));
    DFlipFlop flipflop (.clk(clk), .rst(rst), .D(f[i]), .Q(out[i]));
  end
endgenerate


endmodule