module ALU (
    output [31:0] result,
    output carry,
    input [31:0] src1,
    input [31:0] src2,
    input [5:0] funct
);
    // internal signals
    reg [31:0] ALU_result;
    reg ALU_carry;

    // ALU operation logic, only addu is implemented
    always @(*)
    begin
        if(funct == 6'b001001) // addu
        begin
            {ALU_carry, ALU_result} = src1 + src2;
        end
    end
    
    // output assignment
    assign result = ALU_result;
    assign carry = ALU_carry;

endmodule
