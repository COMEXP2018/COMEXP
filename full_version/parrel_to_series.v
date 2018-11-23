module signal_taker(sig_from_adc,clk_256,reset,sig_for_trans);
  input [7:0]sig_from_adc;
  input clk_256,reset;
  output wire [7:0]sig_for_trans;
  wire [31:0]count;
  
  dtrigger_8 s0
  (
  .d(sig_from_adc),
  .q(sig_for_trans),
  .clk(clk_256),
  .reset(reset)
  );
endmodule

module transfer(sig_for_trans,sig_from_adc,clk_16,reset,trans_enable,control_sig);
  input [7:0]sig_for_trans;
  input [7:0]sig_from_adc;
  input clk_16,reset,trans_enable;
  output reg control_sig;
  reg [4:0]count;
  
always @(negedge clk_16 or negedge reset)
begin
  if(~reset)
    begin
    count=5'd0;
    control_sig=0;
    end
  else if(trans_enable==1)
    begin
    count=1;
    control_sig=sig_from_adc[0];
    end 
  else if(count>5'd7)
    begin
    control_sig=0;
    if(count==5'd16)
      count=0;
    end
  else if(count<5'd8)
    begin
      control_sig=sig_for_trans[count];
      count=count+1;
    end
  else
    count=0;
end

endmodule
  
module parrel_to_series(sig_from_adc,clk_256,clk_16,reset,trans_enable,control_sig);
  input [7:0]sig_from_adc;
  input clk_256,clk_16,reset,trans_enable;
  output wire control_sig;
  wire [7:0]sig_for_trans;
  
  signal_taker s1
  (
  .sig_from_adc(sig_from_adc),
  .clk_256(clk_256),
  .reset(reset),
  .sig_for_trans(sig_for_trans)
  );
  
  transfer s2
  (
  .sig_for_trans(sig_for_trans),
  .sig_from_adc(sig_from_adc),
  .clk_16(clk_16),
  .reset(reset),
  .trans_enable(trans_enable),
  .control_sig(control_sig)
  );
    
endmodule
