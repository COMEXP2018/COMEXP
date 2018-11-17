module control_core(sig_enable,out_enable,clk_16,reset);
  input sig_enable,clk_16,reset;
  output reg out_enable;
  reg [4:0]count;
  
always @(posedge clk_16 or negedge reset)
begin
  if(~reset)
    begin
    count=0;
    out_enable=0;
    end
  else if(sig_enable==1)
    begin
      count=count+1;
      if(count==5'd17)
        out_enable=1;
      if(count==5'd18)
          begin
            out_enable=0;
            count=5'd2;
          end
    end
end
endmodule