module CompMultiplier ( 
    output [63:0] Prod, 
    output Rdy, 
    input [31:0] Mult, 
    input [31:0] Mul, 
    input Run, 
    input Rst, 
    input clk 
);

    // I/O data wires
    wire [31:0] Multiplicand_in;
    wire [31:0] Multiplier_in;
    wire [63:0] Product_out;
    wire [31:0] Hi;

    // internal control signal wires
    wire W_ctrl_Multiplicand;
    wire [5:0] Addu_ctrl;
    wire Adding_ctrl;
    wire W_ctrl_Product;

    // internal data signal wires
    wire [31:0] Multiplicand_out;
    wire [31:0] ALU_result;
    wire ALU_carry;
    wire LSB;
    wire ready;
    
    assign Rdy = ready;

    //output assignment
    assign Prod = Product_out;

    //input assignment
    assign Multiplicand_in = Mult;
    assign Multiplier_in = Mul;

    Multiplicand Multiplicand_register_32bit (
        .multiplicand_out(Multiplicand_out),
        .multiplicand_in(Multiplicand_in),
        .w_ctrl_Multiplicand(W_ctrl_Multiplicand),
        .rst(Rst)
    );

    ALU ALU (
        .result(ALU_result),
        .carry(ALU_carry),
        .src1(Hi),
        .src2(Multiplicand_out),
        .funct(Addu_ctrl)
    );

    Product Product (
        .product_out(Product_out),
        .hi(Hi),
        .alu_result(ALU_result),
        .alu_carry(ALU_carry),
        .multiplier_in(Multiplier_in),
        .adding_ctrl(Adding_ctrl),
        .w_ctrl_Product(W_ctrl_Product),
        .lsb(LSB),
        .rdy(ready),
        .rst(Rst),
        .clk(clk)
    );

    Control Control (
        .rdy(ready),
        .w_ctrl_Multiplicand(W_ctrl_Multiplicand),
        .adding_ctrl(Adding_ctrl),
        .addu_ctrl(Addu_ctrl),
        .w_ctrl_Product(W_ctrl_Product),
        .run(Run),
        .rst(Rst),
        .clk(clk),
        .lsb(LSB)
    );

endmodule