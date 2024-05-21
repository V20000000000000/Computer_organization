module MUX_8bit 
(
    input [6:0] A,
    input [6:0] B,
    input S,
    output [6:0] Y
);
    assign Y = S ? B : A;
endmodule