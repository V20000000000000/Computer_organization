module SignExtender
{
    input [15:0] inputData;
    output [31:0] outputData;
};
    assign output = inputData[15] ? {16'b1111111111111111, inputData} : {16'b0000000000000000, inputData};
endmodule