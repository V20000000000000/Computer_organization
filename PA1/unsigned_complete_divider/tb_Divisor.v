module tb_Divisor;

    // Inputs
    reg [31:0] reg1_in;
    reg w_ctrl_reg1;
    reg rst;
    
    // Outputs
    wire [31:0] reg1_out;

    // Instantiate the Divisor module
    Divisor uut (
        .reg1_out(reg1_out),
        .reg1_in(reg1_in),
        .w_ctrl_reg1(w_ctrl_reg1),
        .rst(rst)
    );

    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;

    // Test case
    initial begin
        // Reset
        rst = 1;
        #10;
        rst = 0;

        // Load data
        w_ctrl_reg1 = 1;
        reg1_in = 32'h12345678;
        #10;

        // Disable control signal
        w_ctrl_reg1 = 0;
        #10;

        // Load new data
        w_ctrl_reg1 = 1;
        reg1_in = 32'hABCDEF01;
        #10;

        // Reset
        rst = 1;
        #10;
        rst = 0;

        // Load new data
        w_ctrl_reg1 = 0;
        reg1_in = 32'hFFFFFFFF;
        #10;

        // Load new data
        w_ctrl_reg1 = 0;
        reg1_in = 32'hFFFFFFFF;
        #10;

        // Stop simulation
        $stop;
    end
    
    // Display results
    always @(posedge clk) begin
        $display("Time: %t, reg1_in: %h, w_ctrl_reg1: %b, reg1_out: %h", $time, reg1_in, w_ctrl_reg1, reg1_out);
    end

endmodule
