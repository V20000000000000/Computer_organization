module IF_ID 
(
    input [31:0] Instruction,
    input IF_ID_write,
    input clk,
    output reg [31:0] Instruction_ID
);

    always @(negedge clk)
    begin
        if (IF_ID_write == 1)
        begin
            Instruction_ID <= Instruction;
        end
    end

endmodule