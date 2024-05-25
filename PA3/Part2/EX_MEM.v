module EX_MEM
(
    input [31:0] ALU_result_in,
    input [31:0] Mem_w_data_in,
    input [4:0] Rd_addr_in,
    input Reg_w_in,
    input Mem_r_in,
    input Mem_w_in,
    input Mem_to_reg_in,
    input clk,
    output reg [31:0] ALU_result_out,
    output reg [31:0] Mem_w_data_out,
    output reg [4:0] Rd_addr_out,
    output reg Reg_w_out,
    output reg Mem_r_out,
    output reg Mem_w_out,
    output reg Mem_to_reg_out
);
    always @(negedge clk)
    begin
        ALU_result_out <= ALU_result_in;
        Rd_addr_out <= Rd_addr_in;
        Reg_w_out <= Reg_w_in;
        Mem_r_out <= Mem_r_in;
        Mem_w_out <= Mem_w_in;
        Mem_to_reg_out <= Mem_to_reg_in;
        Mem_w_data_out <= Mem_w_data_in;
    end

endmodule