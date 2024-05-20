module ID_EX
(
    input [31:0] Rs_data_in, Rt_data_in,
    input [31:0] Imm_in,
    input [1:0] ALU_op_in,
    input [5:0] Funct_ctrl_in,
    input [4:0] shamt_in,
    input [4:0] Rd_addr_in,
    input [4:0] Rt_addr_in,
    input ALU_src_in,
    input Reg_w_in,
    input Reg_dst_in, 
    input Mem_w_in,
    input Mem_r_in,
    input Mem_to_reg_in,
    input clk,
    output reg [31:0] Rs_data_out, Rt_data_out,
    output reg [31:0] Imm_out,
    output reg [5:0] Funct_ctrl_out,
    output reg [4:0] shamt_out,
    output reg [4:0] Rd_addr_out,
    output reg [4:0] Rt_addr_out,
    output reg [1:0] ALU_op_out,
    output reg Reg_w_out,
    output reg ALU_src_out,
    output reg Reg_dst_out,
    output reg Mem_w_out,
    output reg Mem_r_out,
    output reg Mem_to_reg_out
);

    always @(negedge clk)
    begin
        Rs_data_out <= Rs_data_in;
        Rt_data_out <= Rt_data_in;
        Rd_addr_out <= Rd_addr_in;
        Rt_addr_out <= Rt_addr_in;
        shamt_out <= shamt_in;
        Funct_ctrl_out <= Funct_ctrl_in;
        ALU_op_out <= ALU_op_in;
        Reg_w_out <= Reg_w_in;
        Reg_dst_out <= Reg_dst_in;
        ALU_src_out <= ALU_src_in;
        Mem_w_out <= Mem_w_in;
        Mem_r_out <= Mem_r_in;
        Mem_to_reg_out <= Mem_to_reg_in;
        Imm_out <= Imm_in;
    end

endmodule