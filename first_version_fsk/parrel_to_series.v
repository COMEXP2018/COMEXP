module signal_taker(sig_from_adc,clk_256,reset,sig_for_trans);
  input [15:0]sig_from_adc;
  input clk_256,reset;
  output wire [15:0]sig_for_trans;
  
  dtrigger_16 s0
  (
  .d(sig_from_adc),
  .q(sig_for_trans),
  .clk(clk_256),
  .reset(reset)
  );
   
endmodule

module transfer(sig_for_trans,clk_16,reset,control_sig);
  input [15:0]sig_for_trans;
  input clk_16,reset;
  output reg control_sig;
  reg [4:0]count;
  
always @(posedge clk_16 or negedge reset)
begin
  if(~reset)
    begin
    count=5'd0;
    control_sig=0;
    end
  else if(count<5'd16&&sig_for_trans!=16'h0000)
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

module enable_shutter(sig_for_trans,sig_enable,clk_16,reset);
  input [15:0]sig_for_trans;
  input clk_16,reset;
  output reg sig_enable;
  
  always @(posedge clk_16 or negedge reset)
  begin
  if(~reset)
    sig_enable=0;
  else if(sig_for_trans!=16'h0000)
    sig_enable=1;
  else
    sig_enable=0;
  end
  
endmodule
  
module parrel_to_series(sig_from_adc,clk_256,clk_16,reset,control_sig,sig_enable);
  input [15:0]sig_from_adc;
  input clk_256,clk_16,reset;
  output wire control_sig,sig_enable;
  wire [15:0]sig_for_trans;
  
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
  .clk_16(clk_16),
  .reset(reset),
  .control_sig(control_sig)
  );
  
  enable_shutter s3
  (
  .sig_for_trans(sig_for_trans),
  .sig_enable(sig_enable),
  .clk_16(clk_16),
  .reset(reset)
  );
    
endmodule
