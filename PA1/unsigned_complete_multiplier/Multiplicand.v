module Multiplicand (
    output [31:0] multiplicand_out,
    input [31:0] multiplicand_in,
    input w_ctrl_Multiplicand,
    input rst
);

    reg [31:0] multiplicand;    // 32-bit multiplicand register

    // Reset logic, reset multiplicand to 0
    always @(negedge rst)
    begin
        if (rst)
            multiplicand <= 32'b0;
    end

    // Data input control logic, load multiplicand
    always @(posedge w_ctrl_Multiplicand)
    begin
        if (!rst)
            multiplicand <= multiplicand_in;
    end

    // Assign output 
    assign multiplicand_out = multiplicand;

endmodule
