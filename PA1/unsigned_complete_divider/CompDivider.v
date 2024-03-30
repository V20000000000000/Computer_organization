module CompDivider ( 
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
    wire [63:0] reg2_out;
    wire [31:0] Hi;

    // internal control signal wires
    wire w_ctrl_reg1;
    wire w_ctrl_reg2;
    wire SLL_ctrl;
    wire SRL_ctrl;
    wire [5:0] funct;

    // internal data signal wires
    wire [31:0] reg1_out;
    wire [31:0] ALU_result;
    wire ALU_carry;
    wire ready;
    
    assign Rdy = ready;

    //output assignment
    assign R = reg2_out[63:32];
    assign Q = reg2_out[31:0];

    //input assignment

    Divisor reg1 (
        .reg1_out(reg1_out),
        .reg1_in(Dvsr),
        .w_ctrl_reg1(w_ctrl_reg1),
        .rst(Rst)
    );

    ALU ALU (
        .result(ALU_result),
        .src1(Hi), 
        .src2(reg1_out),
        .carry(ALU_carry),
        .funct(funct)
    );

    Remainder reg2 (
        .reg2_out(reg2_out),
        .hi(Hi),
        .alu_result(ALU_result),
        .alu_carry(ALU_carry),
        .reg2_in(Dvnd),
        .w_ctrl_reg2(w_ctrl_reg2),
        .SLL_ctrl(SLL_ctrl),
        .SRL_ctrl(SRL_ctrl),
        .rdy(ready),
        .rst(Rst),
        .clk(clk),
        .run(Run)
    );

    Control Control (
        .rdy(ready),
        .SLL_ctrl(SLL_ctrl),
        .SRL_ctrl(SRL_ctrl),
        .w_ctrl_reg1(w_ctrl_reg1),
        .w_ctrl_reg2(w_ctrl_reg2),
        .run(Run),
        .rst(Rst),
        .clk(clk),
        .funct(funct)
    );

endmodule