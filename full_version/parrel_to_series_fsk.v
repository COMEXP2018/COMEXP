module signal_taker_fsk(sig_from_adc,clk_256,reset,sig_for_trans);
  input [15:0]sig_from_adc;
  input clk_256,reset;
  output wire [15:0]sig_for_trans;
  wire [31:0]count;
  
  dtrigger_16 s0
  (
  .d(sig_from_adc),
  .q(sig_for_trans),
  .clk(clk_256),
  .reset(reset)
  );
   
endmodule

module transfer_fsk(sig_for_trans,sig_from_adc,clk_16,reset,trans_enable,control_sig);
  input [15:0]sig_for_trans;
  input [15:0]sig_from_adc;
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
  else if(count<5'd16)
    begin
      control_sig=sig_for_trans[count];
      if(count<5'd15)
      count=count+1;
      else
      count=0;
    end
  else
    count=0;
end

endmodule
  
module parrel_to_series_fsk(sig_from_adc,clk_256,clk_16,reset,trans_enable,control_sig);
  input [15:0]sig_from_adc;
  input clk_256,clk_16,reset,trans_enable;
  output wire control_sig;
  wire [15:0]sig_for_trans;
  
  signal_taker_fsk s1
  (
  .sig_from_adc(sig_from_adc),
  .clk_256(clk_256),
  .reset(reset),
  .sig_for_trans(sig_for_trans)
  );
  
  transfer_fsk s2
  (
  .sig_for_trans(sig_for_trans),
  .sig_from_adc(sig_from_adc),
  .clk_16(clk_16),
  .reset(reset),
  .trans_enable(trans_enable),
  .control_sig(control_sig)
  );
    
endmodule
