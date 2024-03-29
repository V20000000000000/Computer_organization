module tb_Control;

    reg run, rst, clk, lsb;
    wire rdy, w_ctrl_Multiplicand, adding_ctrl, w_ctrl_Product;
    wire [5:0] addu_ctrl;

    Control dut (
        .run(run),
        .rst(rst),
        .clk(clk),
        .lsb(lsb),
        .rdy(rdy),
        .w_ctrl_Multiplicand(w_ctrl_Multiplicand),
        .adding_ctrl(adding_ctrl),
        .addu_ctrl(addu_ctrl),
        .w_ctrl_Product(w_ctrl_Product)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        run = 0;
        rst = 1;
        clk = 0;
        lsb = 0;

        // Reset sequence
        #10 rst = 0;
        #10 rst = 1;

        // Test Case 1: Basic operation
        $display("Test Case 1: Basic Operation");
        run = 1;
        lsb = 0;
        #20;
        lsb = 1;
        #20;
        run = 0;

        // Test Case 2: Reset behavior
        $display("Test Case 2: Reset Behavior");
        #20;
        rst = 0;
        #20;
        rst = 1;

        // Test Case 3: Edge Cases
        $display("Test Case 3: Edge Cases");
        run = 1;
        lsb = 0;
        #20;
        lsb = 1;
        #20;
        run = 0;

        // Test Case 4: Boundary Cases
        $display("Test Case 4: Boundary Cases");
        run = 1;
        lsb = 0;
        #20;
        lsb = 1;
        #20;
        run = 0;

        // End simulation
        $finish;
    end

endmodule
