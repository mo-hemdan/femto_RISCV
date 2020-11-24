module Full_adder(input x, y, cin, output summ, carry_out

    );
 assign {carry_out, summ} = x+y+cin;
endmodule