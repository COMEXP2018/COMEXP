module Comm_system(data_in,data_out,reset,sysclk);
  input [7:0]data_in;
  input reset,sysclk;
  output wire [7:0]data_out;
  wire [7:0]data_for_coding;
  wire [15:0]data_for_fsk,data_out_fsk;
  wire data_for_coding_series;
  wire clk_1,clk_2,clk_4,clk_8,clk_16,clk_32,clk_64,clk_128,clk_256,clk_512,clk_30,clk_8k;
  wire trans_enable,test_enable;
  
  ClkGen zc0
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

  PCMEncoder zc1
  (
  .in(data_in),
  .out(data_for_coding)
  );
  
  parrel_to_series zc2
  (
  .sig_from_adc(data_for_coding),
  .clk_256(clk_256),
  .clk_16(clk_16),
  .reset(reset),
  .trans_enable(trans_enable),
  .control_sig(data_for_coding_series)
  );
  
  alert_256 zc3
  (
  .sysclk(sysclk),
  .clk_256(clk_256),
  .reset(reset),
  .trans_enable(trans_enable),
  .test_enable(test_enable)
  );
  
  zuzhen zc4
  (
  .din(data_for_coding_series),
  .dout(data_for_fsk),
  .clk(clk_16),
  .reset(reset),
  .enable(test_enable)
  );
  
  fsk_top_mod zc5
  (
  .sig_from_adc(data_for_fsk),
  .sysclk(sysclk),
  .reset(reset),
  .sig_use(data_out_fsk)
  );
  
  PCMDecoder zc6
  (
  .in(data_out_fsk[7:0]),
  .out(data_out)
  );

endmodule