`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2020 01:45:53 PM
// Design Name: 
// Module Name: data_mem
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


module DataMem(
	input clk, 
	input MemRead, 
	input MemWrite,
	input [8:0] addr, //address by byte 
	input [31:0] data_in, 
	input [2:0] funct3, //0(byte), 1(half word), 2(word) //////////////////////////////
	output reg [31:0] data_out
	);
 //reg [31:0] mem [0:63];
 reg [7:0] mem [0:511];
 
 
 initial begin
 
 $readmemh("intelhexatest.mem" ,mem );
 /*
  mem[0] = 8'h00; mem[1] = 8'h4e; mem[2] = 8'h80; mem[3] = 8'hb7;
mem[4] = 8'h00; mem[5] = 8'h00; mem[6] = 8'h00; mem[7] = 8'h33;
mem[8] = 8'h00; mem[9] = 8'h00; mem[10] = 8'h00; mem[11] = 8'h33;
mem[12] = 8'h00; mem[13] = 8'h00; mem[14] = 8'h00; mem[15] = 8'h33;
mem[16] = 8'h03; mem[17] = 8'h00; mem[18] = 8'he0; mem[19] = 8'h93;
mem[20] = 8'h00; mem[21] = 8'h00; mem[22] = 8'h00; mem[23] = 8'h33;
mem[24] = 8'h00; mem[25] = 8'h00; mem[26] = 8'h00; mem[27] = 8'h33;
mem[28] = 8'h00; mem[29] = 8'h00; mem[30] = 8'h00; mem[31] = 8'h33;
mem[32] = 8'h01; mem[33] = 8'hef; mem[34] = 8'he1; mem[35] = 8'h17;
mem[36] = 8'h00; mem[37] = 8'h00; mem[38] = 8'h00; mem[39] = 8'h33;
mem[40] = 8'h00; mem[41] = 8'h00; mem[42] = 8'h00; mem[43] = 8'h33;
mem[44] = 8'h00; mem[45] = 8'h00; mem[46] = 8'h00; mem[47] = 8'h33;
mem[48] = 8'h19; mem[49] = 8'h00; mem[50] = 8'h01; mem[51] = 8'h83; //
mem[52] = 8'h00; mem[53] = 8'h00; mem[54] = 8'h00; mem[55] = 8'h33;
mem[56] = 8'h00; mem[57] = 8'h00; mem[58] = 8'h00; mem[59] = 8'h33;
mem[60] = 8'h00; mem[61] = 8'h00; mem[62] = 8'h00; mem[63] = 8'h33;
mem[64] = 8'h19; mem[65] = 8'h00; mem[66] = 8'h12; mem[67] = 8'h03;
mem[68] = 8'h00; mem[69] = 8'h00; mem[70] = 8'h00; mem[71] = 8'h33;
mem[72] = 8'h00; mem[73] = 8'h00; mem[74] = 8'h00; mem[75] = 8'h33;
mem[76] = 8'h00; mem[77] = 8'h00; mem[78] = 8'h00; mem[79] = 8'h33;
mem[80] = 8'h19; mem[81] = 8'h00; mem[82] = 8'h22; mem[83] = 8'h83;
mem[84] = 8'h00; mem[85] = 8'h00; mem[86] = 8'h00; mem[87] = 8'h33;
mem[88] = 8'h00; mem[89] = 8'h00; mem[90] = 8'h00; mem[91] = 8'h33;
mem[92] = 8'h00; mem[93] = 8'h00; mem[94] = 8'h00; mem[95] = 8'h33;
mem[96] = 8'h18; mem[97] = 8'h50; mem[98] = 8'h0a; mem[99] = 8'h23;
mem[100] = 8'h00; mem[101] = 8'h00; mem[102] = 8'h00; mem[103] = 8'h33;
mem[104] = 8'h00; mem[105] = 8'h00; mem[106] = 8'h00; mem[107] = 8'h33;
mem[108] = 8'h00; mem[109] = 8'h00; mem[110] = 8'h00; mem[111] = 8'h33;
mem[112] = 8'h18; mem[113] = 8'h50; mem[114] = 8'h1c; mem[115] = 8'h23;
mem[116] = 8'h00; mem[117] = 8'h00; mem[118] = 8'h00; mem[119] = 8'h33;
mem[120] = 8'h00; mem[121] = 8'h00; mem[122] = 8'h00; mem[123] = 8'h33;
mem[124] = 8'h00; mem[125] = 8'h00; mem[126] = 8'h00; mem[127] = 8'h33;
mem[128] = 8'h18; mem[129] = 8'h50; mem[130] = 8'h2e; mem[131] = 8'h23;
mem[132] = 8'h00; mem[133] = 8'h00; mem[134] = 8'h00; mem[135] = 8'h33;
mem[136] = 8'h00; mem[137] = 8'h00; mem[138] = 8'h00; mem[139] = 8'h33;
mem[140] = 8'h00; mem[141] = 8'h00; mem[142] = 8'h00; mem[143] = 8'h33;
mem[144] = 8'h00; mem[145] = 8'h00; mem[146] = 8'h81; mem[147] = 8'h33;
mem[148] = 8'h00; mem[149] = 8'h00; mem[150] = 8'h00; mem[151] = 8'h33;
mem[152] = 8'h00; mem[153] = 8'h00; mem[154] = 8'h00; mem[155] = 8'h33;
mem[156] = 8'h00; mem[157] = 8'h00; mem[158] = 8'h00; mem[159] = 8'h33;
mem[160] = 8'h40; mem[161] = 8'h11; mem[162] = 8'h01; mem[163] = 8'h33;
mem[164] = 8'h00; mem[165] = 8'h00; mem[166] = 8'h00; mem[167] = 8'h33;
mem[168] = 8'h00; mem[169] = 8'h00; mem[170] = 8'h00; mem[171] = 8'h33;
mem[172] = 8'h00; mem[173] = 8'h00; mem[174] = 8'h00; mem[175] = 8'h33;
mem[176] = 8'h00; mem[177] = 8'h32; mem[178] = 8'h93; mem[179] = 8'h33;
mem[180] = 8'h00; mem[181] = 8'h00; mem[182] = 8'h00; mem[183] = 8'h33;
mem[184] = 8'h00; mem[185] = 8'h00; mem[186] = 8'h00; mem[187] = 8'h33;
mem[188] = 8'h00; mem[189] = 8'h00; mem[190] = 8'h00; mem[191] = 8'h33;
mem[192] = 8'h00; mem[193] = 8'h32; mem[194] = 8'hd3; mem[195] = 8'hb3;
mem[196] = 8'h00; mem[197] = 8'h00; mem[198] = 8'h00; mem[199] = 8'h33;
mem[200] = 8'h00; mem[201] = 8'h00; mem[202] = 8'h00; mem[203] = 8'h33;
mem[204] = 8'h00; mem[205] = 8'h00; mem[206] = 8'h00; mem[207] = 8'h33;
mem[208] = 8'hf3; mem[209] = 8'h80; mem[210] = 8'h03; mem[211] = 8'h93;
mem[212] = 8'h00; mem[213] = 8'h00; mem[214] = 8'h00; mem[215] = 8'h33;
mem[216] = 8'h00; mem[217] = 8'h00; mem[218] = 8'h00; mem[219] = 8'h33;
mem[220] = 8'h00; mem[221] = 8'h00; mem[222] = 8'h00; mem[223] = 8'h33;
mem[224] = 8'h40; mem[225] = 8'h33; mem[226] = 8'hd3; mem[227] = 8'hb3;
mem[228] = 8'h00; mem[229] = 8'h00; mem[230] = 8'h00; mem[231] = 8'h33;
mem[232] = 8'h00; mem[233] = 8'h00; mem[234] = 8'h00; mem[235] = 8'h33;
mem[236] = 8'h00; mem[237] = 8'h00; mem[238] = 8'h00; mem[239] = 8'h33;
mem[240] = 8'h00; mem[241] = 8'h71; mem[242] = 8'h24; mem[243] = 8'h33;
mem[244] = 8'h00; mem[245] = 8'h00; mem[246] = 8'h00; mem[247] = 8'h33;
mem[248] = 8'h00; mem[249] = 8'h00; mem[250] = 8'h00; mem[251] = 8'h33;
mem[252] = 8'h00; mem[253] = 8'h00; mem[254] = 8'h00; mem[255] = 8'h33;
mem[256] = 8'h00; mem[257] = 8'h73; mem[258] = 8'h34; mem[259] = 8'hb3;
mem[260] = 8'h00; mem[261] = 8'h00; mem[262] = 8'h00; mem[263] = 8'h33;
mem[264] = 8'h00; mem[265] = 8'h00; mem[266] = 8'h00; mem[267] = 8'h33;
mem[268] = 8'h00; mem[269] = 8'h00; mem[270] = 8'h00; mem[271] = 8'h33;
mem[272] = 8'h00; mem[273] = 8'h63; mem[274] = 8'h44; mem[275] = 8'hb3;
mem[276] = 8'h00; mem[277] = 8'h00; mem[278] = 8'h00; mem[279] = 8'h33;
mem[280] = 8'h00; mem[281] = 8'h00; mem[282] = 8'h00; mem[283] = 8'h33;
mem[284] = 8'h00; mem[285] = 8'h00; mem[286] = 8'h00; mem[287] = 8'h33;
mem[288] = 8'hff; mem[289] = 8'hf0; mem[290] = 8'h03; mem[291] = 8'h13;
mem[292] = 8'h00; mem[293] = 8'h00; mem[294] = 8'h00; mem[295] = 8'h33;
mem[296] = 8'h00; mem[297] = 8'h00; mem[298] = 8'h00; mem[299] = 8'h33;
mem[300] = 8'h00; mem[301] = 8'h00; mem[302] = 8'h00; mem[303] = 8'h33;
mem[304] = 8'h00; mem[305] = 8'h60; mem[306] = 8'he4; mem[307] = 8'hb3;
mem[308] = 8'h00; mem[309] = 8'h00; mem[310] = 8'h00; mem[311] = 8'h33;
mem[312] = 8'h00; mem[313] = 8'h00; mem[314] = 8'h00; mem[315] = 8'h33;
mem[316] = 8'h00; mem[317] = 8'h00; mem[318] = 8'h00; mem[319] = 8'h33;
mem[320] = 8'h00; mem[321] = 8'h00; mem[322] = 8'hf0; mem[323] = 8'hb3;
mem[324] = 8'h00; mem[325] = 8'h00; mem[326] = 8'h00; mem[327] = 8'h33;
mem[328] = 8'h00; mem[329] = 8'h00; mem[330] = 8'h00; mem[331] = 8'h33;
mem[332] = 8'h00; mem[333] = 8'h00; mem[334] = 8'h00; mem[335] = 8'h33;
*/
//data memory sector
mem[403] = 8'd22;
mem[402] = 8'd46;
mem[401] = 8'd105;
mem[400] = 8'd5;


end


 always @(negedge clk) begin
   if (MemWrite) begin
       case (funct3)
           3'b000: mem[addr] = data_in[7:0]; 
           3'b001: begin mem[addr] = data_in[7:0]; mem[addr+1] = data_in[15:8]; end
           3'b010: begin mem[addr+3] = data_in [31:24]; mem[addr+1] = data_in[15:8]; mem[addr+2] = data_in[23:16];  mem[addr] = data_in[7:0] ; end
           default: mem[addr] = mem[addr];
       endcase
   end
 end
 always @(*) begin
   if(MemRead) begin
       case (funct3)
           3'b000: data_out = {24'd0, mem[addr]}; 
           3'b001: data_out = {16'd0, mem[addr+1], mem[addr]};
           3'b010: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; ///has been reversed for testing purposes only
           default: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
       endcase
   end
end

//////////////////////***********************////////////////
endmodule
