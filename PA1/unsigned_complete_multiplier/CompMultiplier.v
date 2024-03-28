module CompMultiplier ( 
    output [63:0] Prod, 
    output Rdy, 
    input [31:0] Mult, 
    input [31:0] Mul, 
    input Run, 
    input Rst, 
    input clk 
);

    // I/O control wires
    wire Run;
    wire Reset;
    wire Ready;
    wire clk;
    
    // I/O data wires
    wire [31:0] Multiplicand_in;
    wire [31:0] Multiplier_in;
    wire [63:0] Product_out;

    // internal control signal wires
    wire W_ctrl_Multiplicand;
    wire [5:0] Addu_ctrl;
    wire Srl_ctrl;
    wire W_ctrl_Product;

    // internal data signal wires
    wire [31:0] Multiplicand_out;
    wire [31:0] ALU_result;
    wire ALU_carry;
    wire LSB;

    Multiplicand Multiplicand_register_32bit (
        .multiplicand_out(Multiplicand_out),
        .multiplicand_in(Multiplicand_in),
        .w_ctrl_Multiplicand(W_ctrl_Multiplicand),
        .rst(Reset)
    );

    ALU ALU (
        .result(ALU_result),
        .carry(ALU_carry),
        .src1(Product_out[63:32]),
        .src2(Multiplier_out),
        .funct(Addu_ctrl)
    );

    Product Product (
        .product_out(Product_out),
        .alu_result(ALU_result),
        .alu_carry(ALU_carry),
        .multiplier_in(Multiplier_in),
        .srl_ctrl(Srl_ctrl),
        .w_ctrl_Product(W_ctrl_Product),
        .rdy(Ready),
        .rst(Reset),
        .clk(clk)
    );

    Control Control (
        .rdy(Ready),
        .w_ctrl_Multiplicand(W_ctrl_Multiplicand),
        .srl_ctrl(Srl_ctrl),
        .addu_ctrl(Addu_ctrl),
        .w_ctrl_Product(W_ctrl_Product),
        .run(Run),
        .rst(Reset),
        .clk(clk),
        .lsb(LSB)
    );

    

    
    





endmodule