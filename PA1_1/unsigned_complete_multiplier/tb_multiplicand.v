module tb_Multiplicand;

    // Inputs
    reg [31:0] multiplicand_in;
    reg w_ctrl_Multiplicand;
    reg rst;
    
    // Outputs
    wire [31:0] multiplicand_out;

    // Instantiate the Multiplicand module
    Multiplicand uut (
        .multiplicand_out(multiplicand_out),
        .multiplicand_in(multiplicand_in),
        .w_ctrl_Multiplicand(w_ctrl_Multiplicand),
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
        w_ctrl_Multiplicand = 1;
        multiplicand_in = 32'h12345678;
        #10;

        // Disable control signal
        w_ctrl_Multiplicand = 0;
        #10;

        // Load new data
        w_ctrl_Multiplicand = 1;
        multiplicand_in = 32'hABCDEF01;
        #10;

        // Reset
        rst = 1;
        #10;
        rst = 0;

        // Load new data
        w_ctrl_Multiplicand = 0;
        multiplicand_in = 32'hFFFFFFFF;
        #10;

        // Load new data
        w_ctrl_Multiplicand = 0;
        multiplicand_in = 32'hFFFFFFFF;
        #10;

        // Stop simulation
        $stop;
    end
    
    // Display results
    always @(posedge clk) begin
        $display("Time: %t, multiplicand_in: %h, w_ctrl_Multiplicand: %b, multiplicand_out: %h", $time, multiplicand_in, w_ctrl_Multiplicand, multiplicand_out);
    end

endmodule
