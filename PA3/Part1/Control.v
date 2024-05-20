module Control
(
    input [5:0] Opcode,
    output reg [1:0] ALU_op,
    output reg  Reg_w
);

always @(*)
begin
    case(Opcode)
        6'b000000: begin ALU_op = 2'b10; Reg_w = 1'b1; end // R-type
        default: begin ALU_op = 2'b00; Reg_w = 1'b0; end
    endcase
end

endmodule
