module ID_EX
{
    input [31:0] Rs_data_in, Rt_data_in,
    input [1:0] ALU_op_in,
    input [5:0] Funct_ctrl_in,
    input [4:0] shamt_in,
    input [4:0] Rd_addr_in,
    input Reg_w_in,
    input clk,
    output reg [31:0] Rs_data_out, Rt_data_out,
    output reg [5:0] Funct_ctrl_out,
    output reg [4:0] shamt_out,
    output reg [4:0] Rd_addr_out,
    output reg [1:0] ALU_op_out,
    output reg Reg_w_out
};

    always @(negedge clk)
    begin
        Rs_data_out <= Rs_data_in;
        Rt_data_out <= Rt_data_in;
        Rd_addr_out <= Rd_addr_in;
        shamt_out <= shamt_in;
        Funct_ctrl_out <= Funct_ctrl_in;
        ALU_op_out <= ALU_op_in;
        Reg_w_out <= Reg_w_in;
    end

endmodule