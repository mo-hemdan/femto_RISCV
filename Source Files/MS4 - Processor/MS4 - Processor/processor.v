`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2020 03:27:17 PM
// Design Name: 
// Module Name: processor
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


module single_cycle_processor (
	input ssd_clk,
	input clk, 
	input rst,
	input [1:0] led_sel,
	input [3:0] ssd_sel,
	output [3:0] anode,
	output [6:0] SSD_out,
	output reg [7:0] LED
	);
	wire [31:0] imm_out;
	wire [31:0] MUXALU;
	reg [12:0] ssd_num;
	wire [31:0] ALU_out;
	wire zero_flag;
	wire [3:0] ALU_ctr_out;
	reg [31:0] datamem_out;
	reg clk_2;
	//pipelining part of the world
    wire ID_EX_RegWrite,
    ID_EX_MemRead, ID_EX_MemWrite, ID_EX_MemtoReg , EX_MEM_RegWrite, EX_MEM_MemRead,
    EX_MEM_MemWrite, EX_MEM_MemtoReg ,EX_MEM_Zero,MEM_WB_MemtoReg,MEM_WB_RegWrite,  ID_EX_ALUSrc;
    wire [1:0] ID_EX_Branch;
    wire [1:0] EX_MEM_Branch;
	wire [1:0] ID_EX_ALUOp;
	wire [31:0] ID_EX_rs2;
	wire [31:0] ID_EX_PC;
	wire [31:0] ID_EX_rs1;
	wire [31:0] ID_EX_ImmGen;
	wire [4:0] ID_EX_rd;
	wire [31:0] MEM_WB_ALUresult;
	wire [31:0] MEM_WB_data;
	wire [31:0] EX_MEM_rs2;
	wire [4:0] EX_MEM_rd;
	wire [4:0] ID_EX_ALUCrlsel;
	wire [4:0] ID_EX_rss1;
	wire [4:0] ID_EX_rss2;
	wire [2:0] EX_MEM_funct3;
	wire [31:0] MEM_WB_BranchADDOUT;
	reg [31:0] ALU_in1;
	reg [31:0] ALU_in2;
	wire [1:0] forwardA;
    wire [1:0] forwardB;
	reg stall;
	wire [10:0] control_ID_EX;
	wire [7:0] control_EX_MEM;
    wire [10:0] control_ID_EX_final;
    wire [7:0] control_EX_MEM_final;
    reg [31:0] inst_new;
		
    //
	
	
	
	
	
	//______________________________________________________________________________________________________________________
	////////////////////////////////////////IF STAGE ///////////////////////////////////////////////////////////////////////
	wire [31:0] next_pc;
	wire [31:0] pc;
	wire [31:0] pc_4;
	reg [31:0] inst;
	wire [1:0] pc_sel;
	wire [31:0] EX_MEM_BranchADDOUT;
	wire [31:0] EX_MEM_ALUresult;
	//assign next_pc = (pc_sel==2'b00)? pc_4:((pc_sel==2'b01)? ALU_out :((pc_sel==2'b10)? pc_branch:32'd0));
	assign next_pc = (pc_sel==2'b00)? pc_4:((pc_sel==2'b01)? EX_MEM_ALUresult :((pc_sel==2'b10)? EX_MEM_BranchADDOUT:32'd0));

	register_32 pc_reg(.in(next_pc), .clk(clk), .rst(rst), .load(stall^1'b1), .out(pc));               //PC Register
    wire pc_4_extrabit;
	RCA_32 pc_4_adder(.a(32'd4), .b(pc), .cin(1'b0), .finalnum({pc_4_extrabit, pc_4}));                               //PC+4 Adder	




	
	
	
	wire [31:0] IF_ID_PC;
	wire [31:0] IF_ID_INST;
	wire [31:0] IF_ID_PC_4;	
	wire [31:0] ID_EX_PC_4;
	wire [31:0] EX_MEM_PC_4;
	wire [31:0] MEM_WB_PC_4;

	//______________________________________________________________________________________________________________________
	////////////////////////////////////////ID STAGE ///////////////////////////////////////////////////////////////////////
	wire MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	wire [1:0] ALUOp;	
	wire [31:0] readdata1;
	wire [31:0] readdata2;
	wire carry_flag;
	wire overflow_flag;
	wire sign_flag;
	wire [4:0] shamt_value;
	wire [31:0] pc_branch;
	wire [1:0] Branch;
	
	wire [31:0] MUX_final_final;
	wire [1:0] MEM_WB_RegSrc;
	wire [31:0] MUX_final;
	wire [4:0] MEM_WB_rd;
	wire [1:0] RegSrc;
	
	wire [1:0] ID_EX_RegSrc;
	
	// hazard detection
         always @(*) begin
            if ((IF_ID_INST[19:15] == ID_EX_rd | IF_ID_INST[24:20]== ID_EX_rd) &(ID_EX_MemRead !=1'b0) & (ID_EX_rd !=1'b0))
            stall = 1'b1;
            else
            stall = 1'b0;
            end
	
	  
     
	
                 // handle beq handling stopping EX_MEM
                



	//assign MUX_final_final = MEM_WB_RegSrc[1] ? (MEM_WB_RegSrc[0] ? MUX_final :pc_branch) : (MEM_WB_RegSrc[0] ? pc_4 : MUX_final); 
	assign MUX_final_final = MEM_WB_RegSrc[1] ? (MEM_WB_RegSrc[0] ? MUX_final :MEM_WB_BranchADDOUT) : (MEM_WB_RegSrc[0] ? MEM_WB_PC_4 : MUX_final); //Ithink we need to replace MEM_WB_RegSrc by RegSrc !!!!


	RegFile RegFileV(.clk(~clk), .rst(rst), .readreg1(IF_ID_INST[19:15]), .readreg2(IF_ID_INST[24:20]), .writereg(MEM_WB_rd), .writedata(MUX_final_final), .regwrite(MEM_WB_RegWrite), .readdata1(readdata1), .readdata2(readdata2));
                                                                                                    //Register File
	
	immediate_generator gen (.inst(IF_ID_INST), .gen_out(imm_out));

		//
	control_unit unit (.inst(IF_ID_INST[6:0]), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUsrc(ALUSrc), .RegWrite(RegWrite), .ALUOp(ALUOp), .RegSrc(RegSrc));
	//
	
	
     
	//______________________________________________________________________________________________________________________
	////////////////////////////////////////EX STAGE ///////////////////////////////////////////////////////////////////////
	wire [1:0] EX_MEM_RegSrc;
	wire EX_MEM_Carry, EX_MEM_Overflow, EX_MEM_Sign;
	wire [6:0]NOPz;
    wire [1:0] stall_stop;
    handling_remaining_instructions staller( .opcode(NOPz [5:0]), .distin(NOPz[6]), .stall_stop(stall_stop));
    // conditions for the EBreak to work
    reg [1:0] real_stall_stop;
    always @ (*)
     begin
       if ( (pc_sel != 2'b00))
          real_stall_stop   = 2'b01; // don't stop if there is a branch that is going to flush the Ebreak  
          else
          real_stall_stop = stall_stop;
     end
	
	 // note this is the forwarding
         
         forwarding_unit riscv_forwUnt(.ID_EX_rs1(ID_EX_rss1), .ID_EX_rs2(ID_EX_rss2), .EX_MEM_rd(EX_MEM_rd), .MEM_WB_rd(MEM_WB_rd), .EX_MEM_RegWrite(EX_MEM_RegWrite), .MEM_WB_RegWrite(MEM_WB_RegWrite), .forwardA(forwardA), .forwardB(forwardB));
         always @(*) begin
                 case(forwardA)
                     2'b00: ALU_in1 = ID_EX_rs1;
                     2'b01: ALU_in1 = MUX_final;
                     2'b10: ALU_in1 = EX_MEM_ALUresult;
                     default: ALU_in1 = ID_EX_rs1;
                 endcase
                 
                 case(forwardB)
                     2'b00: ALU_in2 = ID_EX_rs2;
                     2'b01: ALU_in2 = MUX_final;
                     2'b10: ALU_in2 = EX_MEM_ALUresult;
                     default: ALU_in2 = ID_EX_rs2;
                 endcase
             end
	RCA_32 pc_branch_adder(.a(ID_EX_ImmGen), .b(ID_EX_PC), .cin(1'b0), .finalnum(pc_branch));
	
	bit_mux muxer( .w0(ALU_in2), .w1(ID_EX_ImmGen), .s(ID_EX_ALUSrc), .f(MUXALU));
	//assign MUXALU = ALUSrc? imm_out:readdata2;
	
	ALU_ctrl control ( .aluOp(ID_EX_ALUOp), .inst_1(ID_EX_ALUCrlsel[2:0]), .inst_2(ID_EX_ALUCrlsel[3]), .inst_3(ID_EX_ALUCrlsel[4]), .aluSel(ALU_ctr_out));
	

	assign shamt_value = (MUXALU>5'd31)? 5'd31: MUXALU[4:0];

	ALU32bit myALU(.a(ALU_in1), .b(MUXALU), .alufn(ALU_ctr_out), .shamt(shamt_value) , .r(ALU_out), .zf(zero_flag), .cf(carry_flag), .vf(overflow_flag), .sf(sign_flag));
	//
	
	
	
	register_32_variable #(.N(95)) IF_ID(.in({pc_4, pc, inst_new}), .clk(clk), .rst(rst), .load(stall^1'b1), .out({IF_ID_PC_4, IF_ID_PC, IF_ID_INST})); //PC+4:PC:Instr


	// handles controls and beq stopping ID_EX
                 assign control_ID_EX = {ALUSrc, ALUOp, RegWrite,Branch, MemRead, MemWrite, MemtoReg, RegSrc};
                  assign control_ID_EX_final = (stall|pc_sel|(real_stall_stop==2'b01))? 11'b0 : control_ID_EX;
	
	wire [6:0] IF_ID_opcode;
	assign IF_ID_opcode = (real_stall_stop == 2'b10)? 7'b1011100:{IF_ID_INST [20], IF_ID_INST [7:2]}; //full break
	register_32_variable #(.N(197)) ID_EX(
                              .in({IF_ID_PC_4, control_ID_EX_final,IF_ID_PC, readdata1, readdata2, imm_out,IF_ID_INST[5] ,IF_ID_INST[30],IF_ID_INST[14:12], IF_ID_INST[11:7], IF_ID_INST[19:15], IF_ID_INST[24:20], IF_ID_opcode}),
                               .clk(clk), .rst(rst), .load(1'b1), .out({ID_EX_PC_4, ID_EX_ALUSrc, ID_EX_ALUOp, ID_EX_RegWrite,ID_EX_Branch,ID_EX_MemRead, ID_EX_MemWrite,ID_EX_MemtoReg, ID_EX_RegSrc,ID_EX_PC, ID_EX_rs1, ID_EX_rs2, ID_EX_ImmGen, ID_EX_ALUCrlsel, ID_EX_rd, ID_EX_rss1, ID_EX_rss2, NOPz}));
   
    assign control_EX_MEM =  {ID_EX_RegWrite,ID_EX_Branch,ID_EX_MemRead, ID_EX_MemWrite,ID_EX_MemtoReg, ID_EX_RegSrc};
    assign control_EX_MEM_final = (pc_sel)? 7'b0 : control_EX_MEM;
    // handle beq stopping PC
     //assign inst_new = ((pc_sel!=2'b00) & real_stall_stop)? 32'b0000000_00000_00000_000_00000_0110011 :((~real_stall_stop)? 32'b000000000001_00000_000_00000_1110011 : inst);
	always @(*) begin 
	   if(pc_sel != 2'b00) inst_new = 32'b0000000_00000_00000_000_00000_0110011;
	   else begin
	        if(real_stall_stop == 2'b10) inst_new = 32'b000000000001_00000_000_00000_1110011;
	        else inst_new = inst;
	   end
	end
	//assign next_pc = (pc_sel==2'b00)? pc_4:((pc_sel==2'b01)? EX_MEM_ALUresult :((pc_sel==2'b10)? EX_MEM_BranchADDOUT:32'd0));
	
	register_32_variable  #(.N(147)) EX_MEM( 
	.in({ID_EX_PC_4, ALU_out, control_EX_MEM_final , pc_branch, zero_flag, carry_flag, overflow_flag, sign_flag, ALU_in2, ID_EX_rd, ID_EX_ALUCrlsel[2:0]}), .clk(clk), .rst(rst), .load(1'b1), 
	.out({EX_MEM_PC_4, EX_MEM_ALUresult, EX_MEM_RegWrite, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_MemtoReg, EX_MEM_RegSrc,EX_MEM_BranchADDOUT, EX_MEM_Zero,EX_MEM_Carry, EX_MEM_Overflow, EX_MEM_Sign, EX_MEM_rs2, EX_MEM_rd, EX_MEM_funct3 }));
	
	//______________________________________________________________________________________________________________________
	////////////////////////////////////////MEM STAGE ///////////////////////////////////////////////////////////////////////
	branch_ctrl brch_unit(.zf(EX_MEM_Zero), .vf(EX_MEM_Overflow), .sf(EX_MEM_Sign), .cf(EX_MEM_Carry), .branch_sel(EX_MEM_Branch), .funct3(EX_MEM_funct3), .branch_f(pc_sel));
	                                                                                                //Branching unit (controls branching selection lines) 
	
	
	register_32_variable #(.N(136)) MEM_WB(.in({EX_MEM_PC_4, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_RegSrc, EX_MEM_BranchADDOUT, datamem_out,EX_MEM_ALUresult, EX_MEM_rd}), .clk(clk), .rst(rst), .load(1'b1), 
	.out({MEM_WB_PC_4, MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_RegSrc, MEM_WB_BranchADDOUT, MEM_WB_data, MEM_WB_ALUresult, MEM_WB_rd}));
	
	//______________________________________________________________________________________________________________________
	////////////////////////////////////////WB STAGE ///////////////////////////////////////////////////////////////////////
	bit_mux final_muxer( .w0(MEM_WB_ALUresult), .w1(MEM_WB_data), .s(MEM_WB_MemtoReg), .f(MUX_final));

	
	
	
	
	
	
	
	
	
	
	//_______________________________________________________________________________________________________________________
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//                                                 ADDITIONAL COMPONENTS                                               //
	//_____________________________________________________________________________________________________________________//
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	always @(*) begin
      case (led_sel)
        2'b00: begin
        LED [0] = RegWrite ;
        LED [1] = ALUSrc   ;
        LED [2] = ALUOp [0] ;
        LED [3] = ALUOp [1]  ;
        LED [4] = MemRead ;
        LED [5] = MemWrite ;
        LED [6] = MemtoReg ;
        LED [7] = Branch[0] ;
        end
        2'b01: begin
        LED [0] = ALU_ctr_out[0];
        LED [1] = ALU_ctr_out[1];
        LED [2] = ALU_ctr_out[2];
        LED [3] = ALU_ctr_out[3];
        LED [4] = zero_flag ;
        LED [5] = pc_sel[0] ;
        LED [6] = pc_sel[1] ;
        LED [7] = 1'b0 ;
        end
        
        2'b10: begin
        LED [0] = pc[2];
        LED [1] = pc[3];
        LED [2] = pc[4];
        LED [3] = pc[5];
        LED [4] = pc[6];
        LED [5] = pc[7];
        LED [6] = 1'b0 ;
        LED [7] = 1'b0 ;
        end
        
        2'b11: begin
        LED [0] = ALU_out[2];
        LED [1] = ALU_out[3];
        LED [2] = ALU_out[4];
        LED [3] = ALU_out[5];
        LED [4] = ALU_out[6];
        LED [5] = ALU_out[7];
        LED [6] = 1'b0 ;
        LED [7] = 1'b0 ;
        end
        
      endcase
      
      case (ssd_sel)
        4'b0000: ssd_num = pc[15:2];
        4'b0001: ssd_num = pc_4[15:2];
        4'b0010: ssd_num = pc_branch[15:2];
        4'b0011: ssd_num = next_pc[15:2];
        4'b0100: ssd_num = readdata1[13:0];
        4'b0101: ssd_num = readdata2[13:0];
        4'b0110: ssd_num = MUX_final[13:0];
        4'b0111: ssd_num = {1'b0,imm_out[13:1]};
        4'b1000: ssd_num = imm_out[13:1];
        4'b1001: ssd_num = MUXALU[13:0];
        4'b1010: ssd_num = ALU_out[13:0];
        4'b1011: ssd_num = datamem_out[13:0];
    
      endcase
    end
	
	Four_Digit_Seven_Segment_Driver risc_ssd(.clk(ssd_clk), .num(ssd_num), .Anode(anode), .LED_out(SSD_out));
	
	/////////////////////////////////////////CODE FOR SINGLE PORTED MEMORY////////////////////////////////////////
	
	
	reg [8:0] mem_addr;
	reg mem_write, mem_read;
	reg [2:0] mem_funct3;
	reg [31:0] mem_data_in;
	wire [31:0] mem_data_out;
	
	always @(*) begin //it's like a mux so there is no need to add clocks here
		if(clk) begin //EDIT HERE FOR BONUS
			mem_addr = pc[8:0];
			mem_write = 0;
			mem_read = 1;
			mem_funct3 = 3'b010;
			mem_data_in = EX_MEM_rs2;
			inst = mem_data_out;
			datamem_out = datamem_out;
		end else begin
			mem_addr = EX_MEM_ALUresult[8:0];
			mem_write = EX_MEM_MemWrite;
			mem_read = EX_MEM_MemRead;
			mem_funct3 = EX_MEM_funct3;
			mem_data_in = EX_MEM_rs2;
			inst = inst; //nope instruction (add x0, x0, x0)
			datamem_out = mem_data_out;
		end
	end
			
	DataMem data(.clk(clk),  .MemRead(mem_read),  .MemWrite(mem_write), .addr(mem_addr), .data_in(mem_data_in), .data_out(mem_data_out), .funct3(mem_funct3));
endmodule