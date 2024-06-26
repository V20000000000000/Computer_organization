module Product (
    output [63:0] product_out,  
    output [31:0] hi,
    input [31:0] alu_result,
    input alu_carry,
    input [31:0] multiplier_in, 
    input adding_ctrl,
    input w_ctrl_Product,
    output lsb,
    input rdy,
    input rst,
    input clk
);

    reg [64:0] product;   // 64-bit product register

    always @(posedge clk)
    begin
        if(rst)   // reset product to 0
        begin
            product <= 65'b0;
        end
        else 
        begin
            if(!w_ctrl_Product)    // if w_ctrl_Product = 0, load product
            begin
                    product <= {alu_carry, alu_result, multiplier_in};
            end 
            else    // if w_ctrl_Product = 0, not load product 
            begin
                if(adding_ctrl)    // lsb = 1: add and shift right
                begin
                    product <= {1'b0, alu_carry, alu_result, product[31:1]};
                end
                else    // lsb = 0: shift right only
                begin
                    product <= {1'b0, product[63:1]};
                end
            end
        end
    end
    // output assignment
    assign hi = product[63:32];
    assign product_out = product;
    assign lsb = product[0];

endmodule