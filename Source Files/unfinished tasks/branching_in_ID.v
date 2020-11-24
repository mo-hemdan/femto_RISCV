reg z;
wire zeros, carrys, signs, overs;
reg [32:0] c;
reg [N-1:0] p;
reg [N-1:0] g;
integer i;
integer j;
integer k;


always @(*) begin
// assign values to the p
  for (i = 0; i< N; i=i+1)
    begin
       p[i] = a[i] ^ b[i];
    end
  for (j=0; j<N; j = j+1)
    begin
       g[j] = a[j] & b[j];
    end
  c[0]=0;
// assign values to the c
  for (k=1; k<N+1; k = k+1)
    begin
       c[k] = g[k-1] | (p[k-1]&c[k-1]);
    end
if (a ==b)
z = 1'b1;
else
z = 1'b0;
end
assign zeros = z;
assign carrys = c[32];
assign signs = p[31] ^ c[31];
assign overs =( a[31] ^ (~b[31]) ^ sign ^ carry))

branch_ctrl brch_unit(.zf(zeros), .vf(overs), .sf(signs), .cf(carrys), .branch_sel(Branch), .funct3(IF_ID_INST[14:12]), .branch_f(pc_sel));
                                                                                               //Branching unit (controls branching selection lines)

wire control_stall
// hazard detection
         always @(*) begin
            if ((IF_ID_INST[19:15] == ID_EX_rd | IF_ID_INST[24:20]== ID_EX_rd) &(ID_EX_MemRead !=1'b0 ) & (ID_EX_rd !=1'b0))
              begin
                if (pc_sel != 2b'00))
                  begin
                    control_stall = 1'b1; // if it is lw and after it a jump make two nop
                    stall = 1'b0;
                  end
                else
                  begin
                    control_stall = 1'b0; // if it is lw and after it not jump do one nop
                    stall = 1'b1;
                  end
              end
            else if  ((IF_ID_INST[19:15] == ID_EX_rd | IF_ID_INST[24:20]== ID_EX_rd) &(ID_EX_RegWrite !=1'b0 ) & (ID_EX_rd !=1'b0) & (pc_sel != 2b'00))
              begin
                stall = 1'b1; // if it is an arithmatic operation and a branch do one nop
                control_stall = 1'b0;
              end
            else
              begin
                stall = 1'b0; // if there is no lw before current intstruction (whether branch or not) or if there is no branch in current instruction donot stall
                control_stall = 1'b0;
              end
            end


 register_32_variable #(.N(95)) IF_ID(.in({pc_4, pc, inst_new}), .clk(clk), .rst(rst), .load((stall|control_stall)^1'b1), .out({IF_ID_PC_4, IF_ID_PC, IF_ID_INST})); //PC+4:PC:Instr
 assign control_ID_EX_final = (stall|control_stall|pc_sel)? 11'b0 : control_ID_EX;
register_32_variable #(.N(190)) ID_EX(
            .in({IF_ID_PC_4, control_ID_EX_final,IF_ID_PC, readdata1, readdata2, imm_out,IF_ID_INST[5] ,IF_ID_INST[30],IF_ID_INST[14:12], IF_ID_INST[11:7], IF_ID_INST[19:15], IF_ID_INST[24:20]}),
             .clk(clk), .rst(rst), .load(control_stall^1'b1), .out({ID_EX_PC_4, ID_EX_ALUSrc, ID_EX_ALUOp, ID_EX_RegWrite,ID_EX_Branch,ID_EX_MemRead, ID_EX_MemWrite,ID_EX_MemtoReg, ID_EX_RegSrc,ID_EX_PC, ID_EX_rs1, ID_EX_rs2, ID_EX_ImmGen, ID_EX_ALUCrlsel, ID_EX_rd, ID_EX_rss1, ID_EX_rss2}));
  assign control_EX_MEM_final = (pc_sel|control_stall)? 7'b0 : control_EX_MEM;
register_32 pc_reg(.in(next_pc), .clk(clk), .rst(rst), .load((stall|control_stall)^1'b1), .out(pc));  