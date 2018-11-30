module decoder(clk, rst_n, code_in, data_out);

input clk,rst_n;
input [1:0]code_in;
output data_out;

parameter g0=5'b11101,g1=5'b10011,L=6'd7;

wire out_pre;
reg [3:0]M[0:15];
reg [3:0]M_pre[0:15];
wire [3:0]M0[0:15];
wire [3:0]M1[0:15];
reg [L:0]D[0:15];
reg [3:0]s_out;
wire [7:0]comp0,comp1,comp2,comp3,comp4,comp5,comp6;
wire [7:0]comp7,comp8,comp9,comp10,comp11,comp12,comp13;
wire [3:0]comp;
reg [5:0]code_depth;
reg code_en;
reg cnt_depth;
wire out_en;
     
always @(posedge clk or negedge rst_n)
 if(!rst_n)
  code_depth<=6'd0;
 else if(cnt_depth==1'b0&&code_depth==L)
  code_depth<=L;
 else if(cnt_depth==1'b1&&code_depth==6'd0)
  code_depth<=6'd0;
 else if(cnt_depth==1'b0)
  code_depth<=code_depth+1'b1;
 else 
  code_depth<=code_depth-1'b1;
  
assign M0[0]=M_pre[0]+(code_in[0]^(0&g0[0]^ 0&g0[1]^0&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^0&g1[2]^0&g1[3]^0&g1[4]));
assign M1[0]=M_pre[8]+(code_in[0]^(0&g0[0]^0&g0[1]^0&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^0&g1[2]^0&g1[3]^1&g1[4]));

assign M0[1]=M_pre[0]+(code_in[0]^(1&g0[0]^ 0&g0[1]^0&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^0&g1[2]^0&g1[3]^0&g1[4]));
assign M1[1]=M_pre[8]+(code_in[0]^(1&g0[0]^0&g0[1]^0&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^0&g1[2]^0&g1[3]^1&g1[4]));

assign M0[2]=M_pre[1]+(code_in[0]^(0&g0[0]^ 1&g0[1]^0&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^0&g1[2]^0&g1[3]^0&g1[4]));
assign M1[2]=M_pre[9]+(code_in[0]^(0&g0[0]^1&g0[1]^0&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^0&g1[2]^0&g1[3]^1&g1[4]));

assign M0[3]=M_pre[1]+(code_in[0]^(1&g0[0]^ 1&g0[1]^0&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^0&g1[2]^0&g1[3]^0&g1[4]));
assign M1[3]=M_pre[9]+(code_in[0]^(1&g0[0]^1&g0[1]^0&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^0&g1[2]^0&g1[3]^1&g1[4]));

assign M0[4]=M_pre[2]+(code_in[0]^(0&g0[0]^ 0&g0[1]^1&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^1&g1[2]^0&g1[3]^0&g1[4]));
assign M1[4]=M_pre[10]+(code_in[0]^(0&g0[0]^0&g0[1]^1&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^1&g1[2]^0&g1[3]^1&g1[4]));

assign M0[5]=M_pre[2]+(code_in[0]^(1&g0[0]^ 0&g0[1]^1&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^1&g1[2]^0&g1[3]^0&g1[4]));
assign M1[5]=M_pre[10]+(code_in[0]^(1&g0[0]^0&g0[1]^1&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^1&g1[2]^0&g1[3]^1&g1[4]));

assign M0[6]=M_pre[3]+(code_in[0]^(0&g0[0]^ 1&g0[1]^1&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^1&g1[2]^0&g1[3]^0&g1[4]));
assign M1[6]=M_pre[11]+(code_in[0]^(0&g0[0]^1&g0[1]^1&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^1&g1[2]^0&g1[3]^1&g1[4]));

assign M0[7]=M_pre[3]+(code_in[0]^(1&g0[0]^ 1&g0[1]^1&g0[2]^0&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^1&g1[2]^0&g1[3]^0&g1[4]));
assign M1[7]=M_pre[11]+(code_in[0]^(1&g0[0]^1&g0[1]^1&g0[2]^0&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^1&g1[2]^0&g1[3]^1&g1[4]));

assign M0[8]=M_pre[4]+(code_in[0]^(0&g0[0]^ 0&g0[1]^0&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^0&g1[2]^1&g1[3]^0&g1[4]));
assign M1[8]=M_pre[12]+(code_in[0]^(0&g0[0]^0&g0[1]^0&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^0&g1[2]^1&g1[3]^1&g1[4]));

assign M0[9]=M_pre[4]+(code_in[0]^(1&g0[0]^ 0&g0[1]^0&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^0&g1[2]^1&g1[3]^0&g1[4]));
assign M1[9]=M_pre[12]+(code_in[0]^(1&g0[0]^0&g0[1]^0&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^0&g1[2]^1&g1[3]^1&g1[4]));

assign M0[10]=M_pre[5]+(code_in[0]^(0&g0[0]^ 1&g0[1]^0&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^0&g1[2]^1&g1[3]^0&g1[4]));
assign M1[10]=M_pre[13]+(code_in[0]^(0&g0[0]^1&g0[1]^0&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^0&g1[2]^1&g1[3]^1&g1[4]));

assign M0[11]=M_pre[5]+(code_in[0]^(1&g0[0]^ 1&g0[1]^0&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^0&g1[2]^1&g1[3]^0&g1[4]));
assign M1[11]=M_pre[13]+(code_in[0]^(1&g0[0]^1&g0[1]^0&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^0&g1[2]^1&g1[3]^1&g1[4]));

assign M0[12]=M_pre[6]+(code_in[0]^(0&g0[0]^ 0&g0[1]^1&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^1&g1[2]^1&g1[3]^0&g1[4]));
assign M1[12]=M_pre[14]+(code_in[0]^(0&g0[0]^0&g0[1]^1&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 0&g1[1]^1&g1[2]^1&g1[3]^1&g1[4]));

assign M0[13]=M_pre[6]+(code_in[0]^(1&g0[0]^ 0&g0[1]^1&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^1&g1[2]^1&g1[3]^0&g1[4]));
assign M1[13]=M_pre[14]+(code_in[0]^(1&g0[0]^0&g0[1]^1&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 0&g1[1]^1&g1[2]^1&g1[3]^1&g1[4]));

assign M0[14]=M_pre[7]+(code_in[0]^(0&g0[0]^ 1&g0[1]^1&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^1&g1[2]^1&g1[3]^0&g1[4]));
assign M1[14]=M_pre[15]+(code_in[0]^(0&g0[0]^1&g0[1]^1&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(0&g1[0]^ 1&g1[1]^1&g1[2]^1&g1[3]^1&g1[4]));

assign M0[15]=M_pre[7]+(code_in[0]^(1&g0[0]^ 1&g0[1]^1&g0[2]^1&g0[3]^0&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^1&g1[2]^1&g1[3]^0&g1[4]));
assign M1[15]=M_pre[15]+(code_in[0]^(1&g0[0]^1&g0[1]^1&g0[2]^1&g0[3]^1&g0[4]))+(code_in[1]^(1&g1[0]^ 1&g1[1]^1&g1[2]^1&g1[3]^1&g1[4]));

always @(posedge clk)
 if(rst_n)
  begin
      D[0][code_depth] <= (M0[0]<=M1[0])?0:1;
      D[1][code_depth] <= (M0[1]<=M1[1])?0:1;
      D[2][code_depth] <= (M0[2]<=M1[2])?0:1;
      D[3][code_depth] <= (M0[3]<=M1[3])?0:1;
      D[4][code_depth] <= (M0[4]<=M1[4])?0:1;
      D[5][code_depth] <= (M0[2]<=M1[5])?0:1;
      D[6][code_depth] <= (M0[6]<=M1[6])?0:1;
      D[7][code_depth] <= (M0[7]<=M1[7])?0:1;
      D[8][code_depth] <= (M0[8]<=M1[8])?0:1;
      D[9][code_depth] <= (M0[9]<=M1[9])?0:1;
      D[10][code_depth]<= (M0[10]<=M1[10])?0:1;
      D[11][code_depth]<= (M0[11]<=M1[11])?0:1;
      D[12][code_depth]<= (M0[12]<=M1[12])?0:1;
      D[13][code_depth]<= (M0[13]<=M1[13])?0:1;
      D[14][code_depth]<= (M0[14]<=M1[14])?0:1;
      D[15][code_depth]<= (M0[15]<=M1[15])?0:1;
  end

always @(posedge clk or negedge rst_n)
 if(!rst_n)
  begin
  M_pre[0] <= 8'b0;
  M_pre[1] <= 8'b0;
  M_pre[2] <= 8'b0;
  M_pre[3] <= 8'b0;
  M_pre[4] <= 8'b0;
  M_pre[5] <= 8'b0;
  M_pre[6] <= 8'b0;
  M_pre[7] <= 8'b0;
  M_pre[8] <= 8'b0;
  M_pre[9] <= 8'b0;
  M_pre[10]<= 8'b0;
  M_pre[11]<= 8'b0;
  M_pre[12]<= 8'b0;
  M_pre[13]<= 8'b0;
  M_pre[14]<= 8'b0;
  M_pre[15]<= 8'b0;
  end
 else 
      begin
       M_pre[0] <= (M0[0]<=M1[0])?M0[0]:M1[0];
       M_pre[1] <= (M0[1]<=M1[1])?M0[1]:M1[1];
       M_pre[2] <= (M0[2]<=M1[2])?M0[2]:M1[2];
       M_pre[3] <= (M0[3]<=M1[3])?M0[3]:M1[3];
       M_pre[4] <= (M0[4]<=M1[4])?M0[4]:M1[4];
       M_pre[5] <= (M0[5]<=M1[5])?M0[5]:M1[5];
       M_pre[6] <= (M0[6]<=M1[6])?M0[6]:M1[6];
       M_pre[7] <= (M0[7]<=M1[7])?M0[7]:M1[7]; 
       M_pre[8] <= (M0[8]<=M1[8])?M0[8]:M1[8];
       M_pre[9] <= (M0[9]<=M1[9])?M0[9]:M1[9];
       M_pre[10]<= (M0[10]<=M1[10])?M0[10]:M1[10];
       M_pre[11]<= (M0[11]<=M1[11])?M0[11]:M1[11];
       M_pre[12]<= (M0[12]<=M1[12])?M0[12]:M1[12];
       M_pre[13]<= (M0[13]<=M1[13])?M0[13]:M1[13];
       M_pre[14]<= (M0[14]<=M1[14])?M0[14]:M1[14];
       M_pre[15]<= (M0[15]<=M1[15])?M0[15]:M1[15];
      end       
        
always @(posedge clk or negedge rst_n)
 if(!rst_n)
  cnt_depth <= 1'b0;
 else if((cnt_depth==1'b0&&code_depth==L)||(cnt_depth==1'b1&&code_depth==0))
  cnt_depth <= ~cnt_depth; 

assign comp0  = (M_pre[0]<M_pre[1])?{M_pre[0],4'd0}:{M_pre[1],4'd1};
assign comp1  = (M_pre[2]<M_pre[3])?{M_pre[2],4'd2}:{M_pre[3],4'd3};
assign comp2  = (M_pre[4]<M_pre[5])?{M_pre[4],4'd4}:{M_pre[5],4'd5};
assign comp3  = (M_pre[6]<M_pre[7])?{M_pre[6],4'd6}:{M_pre[7],4'd7};
assign comp4  = (M_pre[8]<M_pre[9])?{M_pre[8],4'd8}:{M_pre[9],4'd9};
assign comp5  = (M_pre[10]<M_pre[11])?{M_pre[10],4'd10}:{M_pre[11],4'd11};
assign comp6  = (M_pre[12]<M_pre[13])?{M_pre[12],4'd12}:{M_pre[13],4'd13};
assign comp7  = (M_pre[14]<M_pre[15])?{M_pre[14],4'd14}:{M_pre[15],4'd15};
assign comp8  = (comp0[7:4]<comp1[7:4])?comp0:comp1;
assign comp9  = (comp2[7:4]<comp3[7:4])?comp2:comp3;
assign comp10 = (comp4[7:4]<comp5[7:4])?comp4:comp5;
assign comp11 = (comp6[7:4]<comp7[7:4])?comp6:comp7;
assign comp12 = (comp8[7:4]<comp9[7:4])?comp8:comp9;
assign comp13 = (comp10[7:4]<comp11[7:4])?comp10:comp11;
assign comp   = (comp12[7:4]<comp13[7:4])?comp12[3:0]:comp13[3:0];

always @(posedge clk or negedge rst_n)
 if(!rst_n)
  s_out <= 4'b0;
 else if(code_en&&((cnt_depth==1'b1&&code_depth==L)||(cnt_depth==1'b0&&code_depth==0)))
  s_out <= {D[comp][code_depth],comp[3:1]};
 else if(code_en)  
  s_out <= {D[s_out][code_depth],s_out[3:1]};
  
always @(posedge clk or negedge rst_n)
 if(!rst_n)
  code_en <= 1'b0;
 else if(code_depth==L)
  code_en <= 1'b1;  
  
assign out_en = code_en&&((cnt_depth==1'b1&&code_depth==L)||(cnt_depth==1'b0&&code_depth==0));

assign out_pre_sequence = (out_en)?comp[0]:s_out[0];

read_out duv(clk, rst_n, out_pre_sequence, code_en, data_out);      
  
endmodule  