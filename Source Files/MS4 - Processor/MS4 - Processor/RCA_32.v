module RCA_32(input [31:0] a, input [31:0] b, input cin, output [32:0] finalnum

    );
wire [32:0] carry;
    assign carry[0] = cin;
    
    genvar i;
    generate
        for(i=0; i<32; i=i+1)
        begin
            Full_adder B (.x(a[i]), .y(b[i]), .cin(carry[i]), .summ(finalnum[i]), .carry_out(carry[i+1]));
        end
    endgenerate
    
    assign finalnum [32] = carry[32];
endmodule