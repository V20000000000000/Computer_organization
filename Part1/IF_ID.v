module IF_ID 
(
    input [31:0] Instruction,
    input clk,
    output reg [31:0] Instruction_ID
);

    always @(negedge clk)
    begin
        Instruction_ID <= Instruction;
    end

endmodule