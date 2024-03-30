module Remainder (
    output [63:0] reg2_out,  
    output [31:0] hi,
    input [32:0] alu_result,
    input alu_carry,
    input [31:0] reg2_in, 
    input w_ctrl_reg2,
    input SLL_ctrl,
    input SRL_ctrl,
    input rdy,
    input rst,
    input clk
);

    reg [64:0] reg2;

    always @(negedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            reg2 <= 0;
        end 
        else
        begin
            if (w_ctrl_reg2)   // 1: load reg2
            begin
                reg2 <= reg2_in;
            end
            else if (SRL_ctrl)   // SRL_ctrl == 1: shift right and set leftmost bit 0
            begin
                reg2 <= {1'b0, reg2[63:1]};
            end
            else if (SLL_ctrl)   // SLL_ctrl == 1
            begin
                if (alu_carry)  // alu_carry == 1: shift left and set rightmost bit 0
                begin
                    reg2 <= {reg2[63:1], 1'b0};
                end
                else    // alu_carry == 1: shift left and set rightmost bit 0
                begin
                    reg2 <= {alu_result, reg2[31:0], 1'b1};
                end
            end
        end
    end

endmodule