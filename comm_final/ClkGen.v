/*
512 divide
*/
module ClkGen(
  input 	sys_clk,
  input 	reset,
  output clk_1,
  output reg clk_2,
  output reg clk_4,
  output reg clk_8,
  output reg clk_16,
  output reg clk_32,
  output reg clk_64,
  output reg clk_128,
  output reg clk_256,
  output reg clk_512,
  output reg clk_30,
  output reg clk_8k
  );
  
  reg [8:0] count;
  reg [8:0] tmp;
  reg [3:0] sum;
  reg [3:0] sum_2;
  
  assign clk_1 = sys_clk;
  
  always@(posedge sys_clk or negedge reset)
  begin
	 if(!reset)
	   begin
		  sum <= 0;
		  clk_30 <= 0;
		end
	 else
		begin
		  if(sum == 14)
		    begin
			   sum <= 0;
				clk_30 <= ~clk_30;
			 end
		  else
		    begin
			   sum <= sum + 1;
			 end
		end
  end
  
  always@(posedge sys_clk or negedge reset)
  begin
    if(!reset)
      begin
        clk_2 <= 1'b0;
        clk_4 <= 1'b0;
        clk_8 <= 1'b0;
        clk_16 <= 1'b0;
        clk_32 <= 1'b0;
        clk_64 <= 1'b0;
        clk_128 <= 1'b0;
        clk_256 <= 1'b0;
        clk_512 <= 1'b0;	
        count <= 1'b0;  
        tmp <= 1'b0;
      end
    else
      begin
        if(count[0] != tmp[0] )
          begin
            clk_2 <= ~clk_2;
          end
        if(count[1] != tmp[1] )
          begin
            clk_4 <= ~clk_4;
          end
        if(count[2] != tmp[2] )
          begin
            clk_8 <= ~clk_8;
          end
        if(count[3] != tmp[3] )
          begin
            clk_16 <= ~clk_16;
          end
        if(count[4] != tmp[4] )
          begin
            clk_32 <= ~clk_32;
          end
        if(count[5] != tmp[5] )
          begin
            clk_64 <= ~clk_64;
          end
        if(count[6] != tmp[6] )
          begin
            clk_128 <= ~clk_128;
          end
        if(count[7] != tmp[7] )
          begin
            clk_256 <= ~clk_256;
          end
        if(count[8] != tmp[8] )
          begin
            clk_512 <= ~clk_512;
          end
      tmp <= count;
			count <= count + 9'b000000001;
      end
  end
  
  always@(posedge clk_512 or negedge reset)
  begin
	 if(!reset)
		begin
		  clk_8k <= 0;
		  sum_2 <= 0;
		end
	 else
	   begin
		  if(sum_2 == 14)
		    begin
			   sum_2 <= 0;
				clk_8k <= ~clk_8k;
			 end
		  else
		    begin
			   sum_2 <= sum_2 + 1;
			 end
		end
  end
  endmodule