module DFlipFlop (input clk, input rst, input D, output Q);
reg Qt;

always @ (posedge clk or posedge rst) begin // Asynchronous Reset
if (rst)
Qt <= 1'b0;
else
Qt <= D;
end

assign Q = Qt;

endmodule