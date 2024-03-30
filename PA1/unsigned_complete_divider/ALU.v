module ALU (
    output reg [31:0] result,
    output reg carry,
    input [31:0] src1,
    input [31:0] src2,
    input [5:0] funct
);

    always@(*)
    begin
        if (funct == 6'b001010)
        begin
            {carry, result} = src1 - src2;
        end
    end

endmodule
