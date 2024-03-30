module tb_Control();

    reg run, rst, clk;
    wire rdy, SLL_ctrl, SRL_ctrl, w_ctrl_reg1, w_ctrl_reg2;
    wire [5:0] funct;

    // Instantiate Control module
    Control dut (
        .rdy(rdy),
        .SLL_ctrl(SLL_ctrl),
        .SRL_ctrl(SRL_ctrl),
        .w_ctrl_reg1(w_ctrl_reg1),
        .w_ctrl_reg2(w_ctrl_reg2),
        .funct(funct),
        .run(run),
        .rst(rst),
        .clk(clk)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Stimulus generation
    initial begin
        // Initialize inputs
        run = 0;
        rst = 1;
        clk = 0;

        // Apply reset
        #10 rst = 0;

        // Transition to run state
        #20 run = 1;

        // Stimulate clock and inputs for 100 clock cycles
        repeat (2000) begin
            #5 clk = ~clk;
        end

        // End simulation
        #10 $finish;
    end

    // Display outputs
    initial begin
        $monitor("Time=%0t, rdy=%b, SLL_ctrl=%b, SRL_ctrl=%b, w_ctrl_reg1=%b, w_ctrl_reg2=%b, funct=%b", $time, rdy, SLL_ctrl, SRL_ctrl, w_ctrl_reg1, w_ctrl_reg2, funct);
    end

endmodule
