module CompMultiplier ( 
    output [31:0] Q,
    output [31:0] R,
    output Rdy, 
    input [31:0] Dvsr, 
    input [31:0] Dvnd, 
    input Run, 
    input Rst, 
    input clk 
);

    // I/O data wires
    wire [31:0] reg1_in;
    wire [31:0] reg2_in;
    wire [63:0] reg2_out;
    wire [31:0] Hi;

    // internal control signal wires
    wire w_ctrl_reg1;
    wire [5:0] ALU_control;
    wire [1:0] w_ctrl_reg2;

    // internal data signal wires
    wire [31:0] reg1_out;
    wire [31:0] ALU_result;
    wire ALU_carry;
    wire sign_flag;
    wire ready;
    
    assign Rdy = ready;

    //output assignment
    assign R = reg2_out[63:32];
    assign Q = reg2_out[31:0];

    //input assignment
    assign reg1_in = Dvsr;
    assign reg2_in = Dvnd;

    Divisor reg1 (
        .reg1_out(reg1_out),
        .reg1_in(reg1_in),
        .w_ctrl_reg1(w_ctrl_reg1),
        .rst(Rst)
    );

    ALU ALU (
        .result(ALU_result),
        .carry(ALU_carry),
        .src1(Hi),
        .src2(reg1_out),
        .funct(ALU_control)
    );

    Remainder reg2 (
        .reg2_out(reg2_out),
        .hi(Hi),
        .alu_result(ALU_result),
        .alu_carry(ALU_carry),
        .reg2_in(reg2_in),
        .w_ctrl_reg2(w_ctrl_reg2),
        .sign_flag(sign_flag),
        .rdy(ready),
        .rst(Rst),
        .clk(clk)
    );

    Control Control (
        .rdy(ready),
        .w_ctrl_reg1(w_ctrl_reg1),
        .ALU_control(ALU_control),
        .w_ctrl_reg2(w_ctrl_reg2),
        .run(Run),
        .rst(Rst),
        .clk(clk),
        .sign_flag(sign_flag)
    );

endmodule