module IF_ID 
(
    input [31:0] Instruction,
    input clk,
    output reg [31:0] Instruction_ID
);

    //tb bug
    reg init_reg = 0;

    always @(negedge clk)
    begin
        if(init_reg == 0)
        begin
            Instruction_ID <= 32'bx;
            init_reg <= 1;
        end
        else
        begin
            Instruction_ID <= Instruction;
        end
    end

endmodule