module Product (
    output [63:0] product_out,
    input alu_result,
    input alu_carry,
    input [31:0] multiplier_in, 
    input srl_ctrl,
    input [5:0] w_ctrl_Product,
    input rdy,
    input rst,
    input clk
);

endmodule