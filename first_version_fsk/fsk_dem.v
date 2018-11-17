module fsk_dem_main(sig_rf,sysclk,sig_temp,reset,judge_Ts,sig_enable);
  input sig_rf,sysclk,sig_temp,reset,sig_enable;
  output reg [4:0]judge_Ts;
  reg [4:0]count_len;
  
always @(posedge sysclk or negedge reset)
begin
  if(~reset)
    begin
      judge_Ts=0;
      count_len=0;
    end
  else if(count_len<5'd16&&sig_enable==1)
    begin
      if(sig_rf!=sig_temp)
        judge_Ts=judge_Ts+1;
      if(count_len==5'd15)
      count_len=5'd0;
      else if(count_len==5'd0)
        begin
        judge_Ts=0;
        count_len=count_len+1;
        end
      else
        count_len=count_len+1;
    end
  else
    begin
      judge_Ts=0;
      count_len=0;
    end
end
endmodule

module fsk_dem_judge(judge_Ts,sig_reb);
  input [4:0]judge_Ts;
  output sig_reb;
  
  assign sig_reb=(judge_Ts<5'd6)?0:1;
  
endmodule

module fsk_dem(sig_rf,sysclk,reset,sig_reb,sig_enable);
  input sig_rf,sysclk,reset,sig_enable;
  output wire sig_reb;
  wire sig_temp;
  wire [4:0]judge_Ts;
    
  dtrigger_2 k0
  (
  .d(sig_rf),
  .q(sig_temp),
  .clk(sysclk),
  .reset(reset)
  );
  
  fsk_dem_main k2
  (
  .sig_rf(sig_rf),
  .sysclk(sysclk),
  .sig_temp(sig_temp),
  .reset(reset),
  .judge_Ts(judge_Ts),
  .sig_enable(sig_enable)
  );
  
  fsk_dem_judge k3
  (
  .judge_Ts(judge_Ts),
  .sig_reb(sig_reb)
  );

  
endmodule