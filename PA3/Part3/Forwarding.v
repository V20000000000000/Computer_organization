module Forwarding(
    // output
    output reg [1:0] Forwarding_A,
    output reg [1:0] Forwarding_B,
    // input
    input [4:0] Rs_addr,
    input [4:0] Rt_addr,
    input [4:0] EX_Mem_Rd_addr,
    input [4:0] Mem_WB_Rd_addr,
    input EX_Mem_RegWrite,
    input Mem_WB_RegWrite
);

    // Forwarding logic combined into a single always block
    always @(*) begin
        // Initialize forwarding control signals to no forwarding
        Forwarding_A = 2'b00;
        Forwarding_B = 2'b00;
        
        // Check EX hazard first
        if (EX_Mem_RegWrite && (EX_Mem_Rd_addr != 0)) begin
            // Forwarding A
            if (EX_Mem_Rd_addr == Rs_addr) begin
                Forwarding_A = 2'b10;
            end
            // Forwarding B
            if (EX_Mem_Rd_addr == Rt_addr) begin
                Forwarding_B = 2'b10;
            end
        end
        // Check MEM hazard
        else if (Mem_WB_RegWrite && (Mem_WB_Rd_addr != 0)) begin
            // Forwarding A
            if ((Forwarding_A == 2'b00) && (Mem_WB_Rd_addr == Rs_addr)) begin
                Forwarding_A = 2'b01;
            end
            // Forwarding B
            if ((Forwarding_B == 2'b00) && (Mem_WB_Rd_addr == Rt_addr)) begin
                Forwarding_B = 2'b01;
            end
        end
    end

endmodule
