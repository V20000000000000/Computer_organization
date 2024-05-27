module Forwarding
(
    input [4:0] Rs_addr,
    input [4:0] Rt_addr,
    input [4:0] EX_Mem_Rd_addr,
    input [4:0] Mem_WB_Rd_addr,
    input EX_Mem_RegWrite,
    input Mem_WB_RegWrite,
    output reg [1:0] Forwarding_A,
    output reg [1:0] Forwarding_B
);

    //Forwarding_A (Rs == Rd && reg_w == 1 && rd != 0): 00 -> No Forwarding, 01 -> Forwarding from Mem_WB, 10 -> Forwarding from EX_Mem

    always @(*)
    begin
        if ((Rs_addr == EX_Mem_Rd_addr) && EX_Mem_RegWrite && EX_Mem_Rd_addr != 0)
        begin
            Forwarding_A = 10;
        end
        else if ((Rs_addr == Mem_WB_Rd_addr) && Mem_WB_RegWrite && Mem_WB_Rd_addr != 0) //&& (EX_Mem_Rd_addr != Rs_addr)
        begin
            Forwarding_A = 01;
        end
        else
        begin
            Forwarding_A = 00;
        end
    end

    //Forwarding_B (Rt == Rd && reg_w == 1 && rd != 0): 00 -> No Forwarding, 01 -> Forwarding from Mem_WB, 10 -> Forwarding from EX_Mem

    always @(*)
    begin
        if ((Rt_addr == EX_Mem_Rd_addr) && EX_Mem_RegWrite && EX_Mem_Rd_addr != 0)
        begin
            Forwarding_B = 10;
        end
        else if ((Rt_addr == Mem_WB_Rd_addr) && Mem_WB_RegWrite && Mem_WB_Rd_addr != 0) // && (EX_Mem_Rd_addr != Rt_addr)
        begin
            Forwarding_B = 01;
        end
        else
        begin
            Forwarding_B = 00;
        end
    end

endmodule