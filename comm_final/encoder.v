module encoder(code_in, code_out);
input [7:0]code_in;
output wire [15:0]code_out;

wire [6:0]code1;
wire [6:0]code2;

assign code1[6:3] = code_in[7:4];
assign code1[2] = code_in[7] ^ code_in[6] ^ code_in[5];
assign code1[1] = code_in[7] ^ code_in[6] ^ code_in[4];
assign code1[0] = code_in[7] ^ code_in[5] ^ code_in[4];
					
assign code2[6:3] = code_in[3:0];
assign code2[2] = code_in[3] ^ code_in[2] ^ code_in[1];
assign code2[1] = code_in[3] ^ code_in[2] ^ code_in[0];
assign code2[0] = code_in[3] ^ code_in[1] ^ code_in[0];
					
assign code_out[15:9] = code1[6:0];
assign code_out[8:2] = code2[6:0];
assign code_out[1] = 1'b0;
assign code_out[0] = 1'b0;

endmodule