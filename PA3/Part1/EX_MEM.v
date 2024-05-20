module EX_MEM
(
    input [31:0] ALU_result_in,
    input [4:0] Rd_addr_in,
    input Reg_w_in,
    input clk,
    output reg [31:0] ALU_result_out,
    output reg [4:0] Rd_addr_out,
    output reg Reg_w_out
);

    always @(negedge clk)
    begin
        ALU_result_out <= ALU_result_in;
        Rd_addr_out <= Rd_addr_in;
        Reg_w_out <= Reg_w_in;
    end

endmodule