module fsk_mod(clk_4,clk_8,control_sig,sig_rf);
  input clk_4,clk_8,control_sig;
  output wire sig_rf;
  
  assign sig_rf=(control_sig==0)?clk_8:clk_4;
  
endmodule