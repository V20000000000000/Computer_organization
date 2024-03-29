module Remainder (
    output [63:0] reg2_out,  
    output [31:0] hi,
    input [31:0] alu_result,
    input alu_carry,
    input [31:0] reg2_in, 
    input adding_ctrl,
    input w_ctrl_reg2,
    input lsb,
    input rdy,
    input rst,
    input clk
);

    reg [64:0] product;

    always @(posedge rst or negedge clk)
    begin
        if(rst)
        begin
            product <= 65'b0;
        end
        else
        begin
            if(!w_ctrl_reg2)    // 0: load product
            begin
                    product <= {alu_carry, alu_result, reg2_in};
            end 
            else    // 1: execute product 
            begin
                if(adding_ctrl)    // lsb = 1: add and shift right
                begin
                    product <= {1'b0, alu_carry, alu_result, product[31:1]};
                end
                else    // lsb = 0: shift right only
                begin
                    product <= {2'b00, product[63:1]};
                end
            end
        end
    end

    assign hi = product[63:32];
    assign reg2_out = product;
    assign lsb = product[0];

endmodule