//将八位线性量化编码转换为PCM编码
module PCM(
    input   [7:0]   in,
    output  wire    [7:0]   out
);

assign out[7] = in[7];

always @*
begin
    case(in[6:1])
        6'b00_0000: 
            begin
                out[6:5] <= 2'b00;
                out[4] <= in[0];
                out[3:0] <= 4'b0000;
            end
        6'b00_0001: 
            begin
                out[6:4] <= 3'b010;
                out[3] <= in[0];
                out[2:0] <= 3'b000;
            end
        6'b00_001?: 
            begin
                out[6:4] <= 3'b011;
                out[3:2] <= in[1:0];
                out[1:0] <= 2'b00;
            end
        6'b00_01??: 
            begin
                out[6:4] <= 3'b100;
                out[3:1] <= in[2:0];
                out[0] <= 1'b0;
            end
        6'b00_1???: 
            begin
                out[6:4] <= 3'b101;
                out[3:0] <= in[3:0];
            end
        6'b01_????: 
            begin
                out[6:4] <= 3'b110;
                out[3:0] <= in[3:0];
            end
        6'b1?_????: 
            begin
                out[6:4] <= 3'b111;
                out[3:0] <= in[3:0];
            end
        default: out[6:0] <= 7'b000_0000;
    endcase
end

endmodule