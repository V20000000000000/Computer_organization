module Adder(
    input [31:0] inputAddr,
    input [31:0] inputOffset,
    output [31:0] outputAddr
);

assign outputAddr = inputAddr + inputOffset;

endmodule