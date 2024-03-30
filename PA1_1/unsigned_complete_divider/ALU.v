module ALU (
    output [31:0] result,
    output carry,
    input [31:0] src1,
    input [31:0] src2
);

    assign {carry, result} = src1 - src2;

endmodule
