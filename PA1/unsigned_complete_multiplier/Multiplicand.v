module Multiplicand (
    output [31:0] multiplicand_out,
    input [31:0] multiplicand_in,
    input w_ctrl_Multiplicand,
    input rst
);

    reg [31:0] multiplicand;

    always @(posedge rst)
    begin
        multiplicand <= 32'b0;
    end

    always @(posedge w_ctrl_Multiplicand)
    begin
        if(!rst)
        begin
            multiplicand <= multiplicand_in;
        end
    end

    assign multiplicand_out = multiplicand;

endmodule