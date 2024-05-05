module MUX_32bit 
(
    input [31:0] A,
    input [31:0] B,
    input S,
    output [31:0] Y
);
    assign Y = S ? B : A;
endmodule