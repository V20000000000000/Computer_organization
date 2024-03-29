module Divisor (
    output [31:0] reg1_out,
    input [31:0] reg1_in,
    input w_ctrl_reg1,
    input rst
);

    reg [31:0] reg1;

    always @(posedge rst)
    begin
        reg1 <= 32'b0;
    end

    always @(posedge w_ctrl_reg1)
    begin
        if(!rst)
        begin
            reg1 <= reg1_in;
        end
    end

    assign reg1_out = reg1;

endmodule