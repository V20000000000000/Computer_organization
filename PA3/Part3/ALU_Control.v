module ALU_Control(
    input [5:0] Funct_ctrl,
    input [1:0] ALU_op,
    output reg [5:0] Funct
);

always @(*)
begin
    case(ALU_op)
        2'b00: Funct = 6'b001001; // ADDU (I type)
        2'b01: Funct = 6'b001010; // SUBU (I type)
        2'b10: // R type
            case(Funct_ctrl)
                6'b001011: Funct = 6'b001001; // ADDU 
                6'b001101: Funct = 6'b001010; // SUBU
                6'b100110: Funct = 6'b100001; // SLL
                6'b110110: Funct = 6'b110101; // SLLV
                default: Funct = 6'b000000;
            endcase
        2'b11: Funct = 6'b101010; // SLTI (I type)
        default: Funct = 6'b000000;
    endcase
end

endmodule