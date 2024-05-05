`define ADDU 6'b001001
`define SUBU 6'b001010
`define SLL 6'b100001
`define SLLV 6'b110101
`define SLTI 6'b101010


module ALU
(
    input [31:0] srcA,
    input [31:0] srcB,
    input [5:0] funct,
    input [4:0] shamt,
    output reg [31:0] result,
    output zero
);

assign zero = (result == 32'b0);

always @(*)
begin
    case(funct)
        `ADDU: result = srcA + srcB;
        `SUBU: result = srcA - srcB;
        `SLL: result = srcA << shamt;
        `SLLV: result = srcA << srcB;
        `SLTI: 
            if(srcA < srcB)
                result = 32'b1;
            else
                result = 32'b0;
        default: result = 32'b0;
    endcase
end    

endmodule