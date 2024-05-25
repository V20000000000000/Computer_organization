module Hazard_detection
(
    input [4:0] ID_EX_Rt_addr,
    input [4:0] IF_ID_Rs_addr,
    input [4:0] IF_ID_Rt_addr,
    input ID_EX_MemRead,
    output reg IF_ID_write,  
    output reg isControl,
    output reg PC_Write,
    output reg addr_ctrl
);

//  if (ID/EX.MemRead and
//  ((ID/EX.RegisterRt = = IF/ID.RegisterRs) or
//  (ID/EX.RegisterRt = = IF/ID.registerRt))
//  stall the pipeline for one cycle
//  (ID/EX.MemRead=1 indicates a load instruction)

initial 
begin
    IF_ID_write = 1;
    isControl = 1;
    PC_Write = 1;
    addr_ctrl = 1;
end

    always @(*)
    begin
        if (ID_EX_MemRead && ((ID_EX_Rt_addr == IF_ID_Rs_addr) || (ID_EX_Rt_addr == IF_ID_Rt_addr)))
        begin   // not change PC and IF/ID
            IF_ID_write = 0;    
            isControl = 0;
            PC_Write = 0;
            addr_ctrl = 0;
        end
        else
        begin
            IF_ID_write = 1;
            isControl = 1;
            PC_Write = 1;
            addr_ctrl = 1;
        end
    end

endmodule