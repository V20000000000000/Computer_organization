module MEM_WB
(
    input [31:0] Mem_r_data_in,
    input [31:0] ALU_result_in,
    input [4:0] Rd_addr_in,
    input Reg_w_in,
    input Mem_to_reg_in,
    input clk,
    output reg [31:0] Mem_r_data_out,
    output reg [31:0] ALU_result_out,
    output reg [4:0] Rd_addr_out,
    output reg Mem_to_reg_out,
    output reg Reg_w_out
);

    always @(negedge clk)
    begin
        Mem_r_data_out <= Mem_r_data_in;
        Rd_addr_out <= Rd_addr_in;
        Reg_w_out <= Reg_w_in;
        Mem_to_reg_out <= Mem_to_reg_in;
        ALU_result_out <= ALU_result_in;
    end

endmodule