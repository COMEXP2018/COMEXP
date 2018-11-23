module read_out(clk, rst_n, out_pre_sequence, code_en, data_out);
input clk,rst_n,out_pre_sequence;
input code_en;
output data_out;

parameter L=7;

reg sq,read_en;
reg [5:0] write_address;
reg [L:0] out_data_register;
wire out_pre_delay;
reg data_out;

always @(posedge clk or negedge rst_n)
 if(!rst_n)
  write_address <= 0;
 else if(code_en&&(sq==0&&write_address==L))
  write_address <= L;
 else if(code_en&&(sq==1&&write_address==0))
  write_address <= 0;
 else if(code_en&&sq==0)
  write_address <=write_address+1'b1;
 else if(code_en&&sq==1)
  write_address <=write_address-1'b1;
  
always @(posedge clk or negedge rst_n)
 if(!rst_n)
  sq <=0;
 else if((sq==0&&write_address==L)||(sq==1&&write_address==0))
  sq <= ~sq;  
  
always @(posedge clk or negedge rst_n)
 if(!rst_n)
 out_data_register <= 16'b0;
 else
 out_data_register[write_address] <= out_pre_sequence;
 
 always @(posedge clk or negedge rst_n) 
  if(!rst_n)
   read_en <= 1'b0;
  else if(write_address==L)
   read_en <= 1'b1;
       
assign out_pre_delay = (read_en)?out_data_register[write_address]:1'bx;

always @(posedge clk or negedge rst_n)
 if(!rst_n)
  data_out<=1'b0;
 else 
  data_out<=out_pre_delay;

endmodule
