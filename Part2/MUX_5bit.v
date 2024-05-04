module MUX_5bit 
{
    input [4:0] A;
    input [4:0] B;
    input S;
    output [4:0] Y;
};
    assign Y = S ? B : A;
endmodule