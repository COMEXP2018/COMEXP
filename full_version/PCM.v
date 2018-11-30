//Convert 8bit linear code to 8bit PCM code
module PCMEncoder(
    input [7:0] in,
    output reg [7:0] out
);

always @*
begin
    out[7] <= in[7];
    casez(in[6:1])
        6'b00_0000: out[6:0] <= {2'b00, in[0], 4'b0000};
        6'b00_0001: out[6:0] <= {3'b010, in[0], 3'b000};
        6'b00_001?: out[6:0] <= {3'b011, in[1:0], 2'b00};
        6'b00_01??: out[6:0] <= {3'b100, in[2:0], 1'b0};
        6'b00_1???: out[6:0] <= {3'b101, in[3:0]};
        6'b01_????: out[6:0] <= {3'b110, in[4:1]};
        6'b1?_????: out[6:0] <= {3'b111, in[5:2]};
        default: out[6:0] <= 7'b000_0000;
    endcase
end

endmodule

//convert 8bit PCM code to 8bit linear code
module PCMDecoder(
    input [7:0] in,
    output reg [7:0] out
);

always @*
begin
    out[7] <= in[7];
    casez(in[6:4])
        3'b00?: out[6:0] <= {6'b00_0000, in[4]};
        3'b010: out[6:0] <= {6'b00_0001, in[3]};
        3'b011: out[6:0] <= {5'b0_0001, in[3:2]};
        3'b100: out[6:0] <= {4'b0001, in[3:1]};
        3'b101: out[6:0] <= {3'b001, in[3:0]};
        3'b110: out[6:0] <= {2'b01, in[3:0], 1'b0};
        3'b111: out[6:0] <= {1'b1, in[3:0], 2'b00};
        default: out[6:0] <= 7'b000_0000;
    endcase
end

endmodule