module ALU_Control(
    input [5:0] Funct_ctrl,
    input [1:0] ALU_op,
    output reg [5:0] Funct
);

always @(*)
begin
    if(ALU_op == 2'b10)
    begin
        case(Funct_ctrl)
            6'b001011: Funct = 6'b001001; // ADDU
            6'b001101: Funct = 6'b001010; // SUBU
            6'b100110: Funct = 6'b100001; // SLL
            6'b110110: Funct = 6'b110101; // SLLV
            default: Funct = 6'b000000; // AND
        endcase
    end
    else
    begin
        Funct = 6'b000000; // AND
    end
end

endmodule