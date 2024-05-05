module ShiftLeft_32to32bits
(
    input [31:0] inputData,
    output [31:0] outputData
);
    assign outputData = {inputData[29:0], 2'b00};

endmodule