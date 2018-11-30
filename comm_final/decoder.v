module decoder(clk, reset, code_in, code_out, decode_enable);
input clk, reset, decode_enable;
input [15:0]code_in;
output reg [7:0]code_out;

reg [6:0]code1;
reg [6:0]code2;
reg [2:0]check1;
reg [2:0]check2;

always @(posedge clk)
begin
	if(reset == 1)
		begin
			if(decode_enable == 1)
				begin
					code1[6:0] = code_in[15:9];
					check1[2] = code1[6] + code1[5] + code1[4] + code1[2];
					check1[1] = code1[6] + code1[5] + code1[3] + code1[1];
					check1[0] = code1[6] + code1[4] + code1[3] + code1[0];
					
					case(check1)
						3'b011:code1[6:3] = code_in[15:12] ^ 4'b0001;
						3'b101:code1[6:3] = code_in[15:12] ^ 4'b0010;
						3'b110:code1[6:3] = code_in[15:12] ^ 4'b0100;
						3'b111:code1[6:3] = code_in[15:12] ^ 4'b1000;
					endcase
					
					code_out[7:4] = code1[6:3];
					
					
					code2[6:0] = code_in[8:2];
					check2[2] = code2[6] + code2[5] + code2[4] + code2[2];
					check2[1] = code2[6] + code2[5] + code2[3] + code2[1];
					check2[0] = code2[6] + code2[4] + code2[3] + code2[0];
					
					case(check2)
						3'b011:code2[6:3] = code_in[8:5] ^ 4'b0001;
						3'b101:code2[6:3] = code_in[8:5] ^ 4'b0010;
						3'b110:code2[6:3] = code_in[8:5] ^ 4'b0100;
						3'b111:code2[6:3] = code_in[8:5] ^ 4'b1000;
					endcase
					
					code_out[3:0] = code2[6:3];
				end
		end
end
endmodule