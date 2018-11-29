module series_to_parrel_fsk(sig_reb,clk_16,trans_enable,reset,sig_use);
  input sig_reb,clk_16,trans_enable,reset;
  output wire [15:0]sig_use;
  wire [15:0]sig_save;
  
  dtrigger_1 c0
  (
  .d(sig_reb),
  .q(sig_save[15]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c1
  (
  .d(sig_save[15]),
  .q(sig_save[14]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c2
  (
  .d(sig_save[14]),
  .q(sig_save[13]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c3
  (
  .d(sig_save[13]),
  .q(sig_save[12]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c4
  (
  .d(sig_save[12]),
  .q(sig_save[11]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c5
  (
  .d(sig_save[11]),
  .q(sig_save[10]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c6
  (
  .d(sig_save[10]),
  .q(sig_save[9]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c7
  (
  .d(sig_save[9]),
  .q(sig_save[8]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c8
  (
  .d(sig_save[8]),
  .q(sig_save[7]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c9
  (
  .d(sig_save[7]),
  .q(sig_save[6]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c10
  (
  .d(sig_save[6]),
  .q(sig_save[5]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c11
  (
  .d(sig_save[5]),
  .q(sig_save[4]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c12
  (
  .d(sig_save[4]),
  .q(sig_save[3]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c13
  (
  .d(sig_save[3]),
  .q(sig_save[2]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c14
  (
  .d(sig_save[2]),
  .q(sig_save[1]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_1 c15
  (
  .d(sig_save[1]),
  .q(sig_save[0]),
  .clk(clk_16),
  .reset(reset)
  );
  
  dtrigger_sin x1
  (
  .d(sig_save),
  .q(sig_use),
  .clk(trans_enable),
  .reset(reset)
  );
  
endmodule