module ALU (
    output [31:0] result,
    output carry,
    input [31:0] src1,
    input [31:0] src2,
    input [5:0] funct
);

    reg [31:0] ALU_result;
    reg ALU_carry;

    always @(*)
    begin
        case (funct)
            6'b001001: 
                begin
                    {ALU_carry, ALU_result} = src1 + src2;
                end
            6'b001010:
                begin
                    {ALU_carry, ALU_result} = src1 - src2;
                end
            default: 
                begin
                    ALU_result = 32'b0;
                    ALU_carry = 1'b0;
                end
    endcase
    end
    
    // output assignment
    assign result = ALU_result;
    assign carry = ALU_carry;

endmodule
