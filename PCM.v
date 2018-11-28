//Convert 13bit linear code to 8bit PCM code
module PCMEncoder(
    input [12:0] in,
    output reg [7:0] out
);

always @*
begin
    out[7] <= in[12];
    casez(in[11:6])
        6'b00_0000: out[6:0] <= {2'b00, in[5:1]};
        6'b00_0001: out[6:0] <= {3'b010, in[5:2]};
        6'b00_001?: out[6:0] <= {3'b011, in[6:3]};
        6'b00_01??: out[6:0] <= {3'b100, in[7:4]};
        6'b00_1???: out[6:0] <= {3'b101, in[8:5]};
        6'b01_????: out[6:0] <= {3'b110, in[9:6]};
        6'b1?_????: out[6:0] <= {3'b111, in[10:7]};
        default: out[6:0] <= 7'b000_0000;
    endcase
end

endmodule

//convert 13bit PCM code to 8bit linear code
module PCMDecoder(
    input [7:0] in,
    output reg [12:0] out
);

always @*
begin
    out[12] <= in[7];
    casez(in[6:4])
        3'b00?: out[11:0] <= {6'b00_0000, in[4:0], 1'b1};
        3'b010: out[11:0] <= {6'b00_0001, in[3:0], 2'b10};
        3'b011: out[11:0] <= {5'b0_0001, in[3:0], 3'b100};
        3'b100: out[11:0] <= {4'b0001, in[3:0], 4'b1000};
        3'b101: out[11:0] <= {3'b001, in[3:0], 5'b1_0000};
        3'b110: out[11:0] <= {2'b01, in[3:0], 6'b10_0000};
        3'b111: out[11:0] <= {1'b1, in[3:0], 7'b100_0000};
        default: out[11:0] <= 12'b0000_0000_0000;
    endcase
end

endmodule
