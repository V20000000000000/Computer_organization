module MUX_32_2bit
(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [1:0] S,
    output [31:0] Y
);
    always @(*)
    begin
        case(S)
            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            2'b11: Y = 32'b0;
        endcase
    end
endmodule