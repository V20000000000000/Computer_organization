module Remainder (
    output [63:0] reg2_out,  
    output [31:0] hi,
    input [31:0] alu_result,
    input alu_carry,
    input [31:0] reg2_in, 
    input w_ctrl_reg2,
    input SLL_ctrl,
    input SRL_ctrl,
    input rdy,
    input rst,
    input clk,
    input run
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
            if (w_ctrl_reg2)    // load reg2
            begin
                reg2 <= {32'b0,reg2_in, 1'b0};
            end
            else
            begin
            if (SRL_ctrl)   // shift right
            begin
                reg2 <= {1'b0,reg2[64:33], reg2[31:0]};
            end
            else 
            begin
                if (alu_carry)      
                begin   // remainder negative >> subtract and add, means keep the same value and shift left
                    reg2 <= {reg2[63:0], 1'b0}; //set rightmost bit to 0
                end
                else    // remainder positive >> subtract and shift left
                begin   //set rightmost bit to 1
                    reg2 <= {alu_result, reg2[31:0], 1'b1};
                end
            end
            end
        end
    end
    // output assignment
    assign hi = reg2[63:32];
    assign reg2_out = reg2[63:0]; 

endmodule