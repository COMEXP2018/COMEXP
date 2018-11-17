module fsk_top_mod_tb;
  reg sysclk,reset;
  reg [15:0]sig_from_adc;
  wire [15:0]sig_use;
  
  fsk_top_mod uut(.sig_from_adc(sig_from_adc),.sysclk(sysclk),.reset(reset),.sig_use(sig_use));
  
  initial fork
    reset=0;
    sysclk=0;
    sig_from_adc=16'h0000;
    #32 reset=1;
    #1 sig_from_adc=16'b0110_1001_1100_0011;
    #1025 sig_from_adc=16'b1110_1111_1010_1011;
    #3072 $stop;
  join
  
  always #2 sysclk<=~sysclk;
  
endmodule