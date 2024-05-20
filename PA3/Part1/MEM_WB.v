module MEM_WB
(
    input [31:0] DM_data_in,
    input [4:0] Rd_addr_in,
    input Reg_w_in,
    input clk,
    output reg [31:0] DM_data_out,
    output reg [4:0] Rd_addr_out,
    output reg Reg_w_out
);

    always @(negedge clk)
    begin
        DM_data_out <= DM_data_in;
        Rd_addr_out <= Rd_addr_in;
        Reg_w_out <= Reg_w_in;
    end

endmodule