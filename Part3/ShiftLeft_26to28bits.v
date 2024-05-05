module ShiftLeft_26to28bits
(
    input [25:0] inputData,
    output [27:0] outputData
);
    assign outputData = {inputData, 2'b00};

endmodule