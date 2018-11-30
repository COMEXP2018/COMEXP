module dtrigger_1(d,q,clk,reset);
input d,reset,clk;
output reg q;

always @(posedge clk or negedge reset)
begin
  if(~reset)
    q<=0;
  else
    q<=d;
end
endmodule

module dtrigger_2(d,q,clk,reset);
input d,reset,clk;
output reg q;

always @(posedge clk or negedge reset)
begin
  if(~reset)
    q<=0;
  else
    q<=d;
end
endmodule

module dtrigger_16(d,q,clk,reset);
  input clk,reset;
  input [15:0]d;
  output reg [15:0]q;
  
always @(posedge clk or negedge reset)
begin
  if(~reset)
    q<=16'h0000;
  else
    q<=d;
end
endmodule