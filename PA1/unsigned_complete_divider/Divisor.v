module Divisor (
    output [31:0] reg1_out,
    input [31:0] reg1_in,
    input w_ctrl_reg1,
    input rst
);

    reg [31:0] reg1;

    always @(posedge w_ctrl_reg1 or posedge rst) begin
        if (rst) 
        begin
            reg1 <= 32'b0;
        end 
        else if (w_ctrl_reg1) 
        begin
            reg1 <= reg1_in;
        end
    end
    
    assign reg1_out = reg1_in;

endmodule

