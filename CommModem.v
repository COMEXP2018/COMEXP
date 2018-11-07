/*************Top Moduel************/

module CommModem(
    input sys_clk,
    input reset,
    input [7:0] DA,
    output reg [7:0] DBP1
);

wire clk_1, clk_2, clk_4, clk_8, clk_16, clk_32;
wire clk_64, clk_128, clk_256, clk_512, clk_30, clk_8k;
wire [7:0] pcmen_in, pcmen_out, pcmde_in, pcmde_out;  //inputs & outputs of PCM encoder & PCM decoder

assign pcmen_in[7:0] = DA[7:0];

//Generate clk signals
ClkGen cg(
    .sys_clk(sys_clk),
    .reset  (reset  ),
    .clk_1  (clk_1  ),
    .clk_2  (clk_2  ),
    .clk_4  (clk_4  ),
    .clk_8  (clk_8  ),
    .clk_16 (clk_16 ),
    .clk_32 (clk_32 ),
    .clk_64 (clk_64 ),
    .clk_128(clk_128),
    .clk_256(clk_256),
    .clk_512(clk_512),
    .clk_30 (clk_30 ),
    .clk_8k (clk_8k )
);

//PCM encoder
PCMEncoder pcmen(
    .in(pcmen_in),
    .out(pcmen_out)
);

//PCM decoder
PCMEncoder pcmde(
    .in(pcmde_in),
    .out(pcmde_out)
);

endmodule