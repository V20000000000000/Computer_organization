module Control
(
    input [5:0] Opcode,
    output Reg_dst,
    output Reg_w,
    output [1:0] ALU_op,
    output ALU_src,
    output Mem_w,
    output Mem_r,
    output Mem_to_reg
);

case(Opcode)
    6'b000000: // R type
        begin
            Reg_dst = 1'b1; // rd
            Reg_w = 1'b1;   // Write to register rd
            ALU_op = 2'b10; // R type
            ALU_src = 1'b0; // R type
            Mem_w = 1'b0;   // Not used data memory
            Mem_r = 1'b0;   // Not used data memory
            Mem_to_reg = 1'b0;  // data from ALU
        end
    6'b010001: // LW
        begin
            Reg_dst = 1'b0; // write to rt
            Reg_w = 1'b1;   // Write to register rt
            ALU_op = 2'b00; // ADDU
            ALU_src = 1'b1; // I type
            Mem_w = 1'b0;   // Not write data memory
            Mem_r = 1'b1;   // Read data memory
            Mem_to_reg = 1'b1; // data from memory
        end
    6'b010000: // SW
        begin
            Reg_dst = 1'b0; // write to rt
            Reg_w = 1'b0;   // not write to register
            ALU_op = 2'b00; // ADDU
            ALU_src = 1'b1; // I type
            Mem_w = 1'b1;  // Write data memory (store)
            Mem_r = 1'b0;  // Don't care
            Mem_to_reg = 1'b0;  // Don't care
        end
    6'b001101: // Subiu
        begin
            Reg_dst = 1'b0; // write to rt
            Reg_w = 1'b1;   // write to register
            ALU_op = 2'b01; // SUBU
            ALU_src = 1'b1; // I type
            Mem_w = 1'b0;  // Not write data memory
            Mem_r = 1'b1;  // Don't care
            Mem_to_reg = 1'b0;  // data from ALU
        end
    6'b101010: // SLTI
        begin
            Reg_dst = 1'b0; // write to rt
            Reg_w = 1'b1;   // not write to register
            ALU_op = 2'b11; // SLTI
            ALU_src = 1'b1; // I type
            Mem_w = 1'b0;  // Not write data memory
            Mem_r = 1'b1;  // Don't care
            Mem_to_reg = 1'b0;  // data from ALU
        end

endmodule
