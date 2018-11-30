module fsk_top_mod(sig_from_adc,sysclk,reset,sig_use);
  input [15:0]sig_from_adc;
  input sysclk,reset;
  output wire [15:0]sig_use;
  wire clk_1,clk_2,clk_4,clk_8,clk_16,clk_32,clk_64,clk_128,clk_256,clk_512,clk_30,clk_8k;
  wire control_sig,sig_rf,sig_reb;
  wire trans_enable,test_enable;
  
  ClkGen z0
  (
  .sys_clk(sysclk),
  .reset(reset),
  .clk_1(clk_1),
  .clk_2(clk_2),
  .clk_4(clk_4),
  .clk_8(clk_8),
  .clk_16(clk_16),
  .clk_32(clk_32),
  .clk_64(clk_64),
  .clk_128(clk_128),
  .clk_256(clk_256),
  .clk_512(clk_512),
  .clk_30(clk_30),
  .clk_8k(clk_8k)
  );
  
  parrel_to_series_fsk z1
  (
  .sig_from_adc(sig_from_adc),
  .clk_256(clk_256),
  .clk_16(clk_16),
  .reset(reset),
  .trans_enable(trans_enable),
  .control_sig(control_sig)
  );
  
  alert_256 z2
  (
  .sysclk(sysclk),
  .clk_256(clk_256),
  .reset(reset),
  .trans_enable(trans_enable),
  .test_enable(test_enable)
  );
  
  fsk_mod z3
  (
  .clk_4(clk_4),
  .clk_8(clk_8),
  .control_sig(control_sig),
  .sig_rf(sig_rf)
  );
  
  fsk_dem z4
  (
  .sig_rf(sig_rf),
  .sysclk(sysclk),
  .reset(reset),
  .sig_reb(sig_reb),
  .trans_enable(trans_enable)
  );
  
  series_to_parrel_fsk z5
  (
  .sig_reb(sig_reb),
  .clk_16(clk_16),
  .trans_enable(trans_enable),
  .reset(reset),
  .sig_use(sig_use)
  );
  
endmodule