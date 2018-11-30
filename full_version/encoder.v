module encoder(clk, rst_n, data_in, code_out);

input clk, rst_n;
input data_in;
output [1:0]code_out;

reg data_delay;
wire [1:0] out_pre_delay;
reg  [1:0]code_out;
reg  [4:0]register;
reg  decode_en;

parameter g0=5'b11101,g1=5'b10011;

always @(negedge clk or negedge rst_n)
 if(!rst_n)
  data_delay <=1'b0;
 else
  data_delay <=data_in;
   
always @(negedge clk or negedge rst_n)
 if(!rst_n)
  code_out<=2'b0;
 else
  code_out<=out_pre_delay;
     
always @(negedge clk or negedge rst_n)
 if(!rst_n)
  register <= 5'b0;
 else 
  register <= {register[3:0],data_delay};
    
assign out_pre_delay[0] = register[4]&g0[4]^register[3]&g0[3]^register[2]&g0[2]^register[1]&g0[1]^register[0]&g0[0]; 
assign out_pre_delay[1] = register[4]&g1[4]^register[3]&g1[3]^register[2]&g1[2]^register[1]&g1[1]^register[0]&g1[0];
  
endmodule
