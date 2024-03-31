module tb_Control;

    // Inputs
    reg run;
    reg rst;
    reg lsb;
    
    // Outputs
    wire rdy;
    wire SLL_ctrl;
    wire SRL_ctrl;
    wire w_ctrl_reg1;
    wire w_ctrl_reg2;
    wire [5:0] funct;

    // Clock generation
    reg clk = 0;
    always begin
        #5; // Change this delay value according to your desired clock period
        clk = ~clk;
    end
    
    // Instantiate the Control module
    Control uut (
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

    // Test case generation
    initial begin
        // Initialize inputs
        run = 0;
        rst = 1;
        lsb = 0;
        #20; // Wait for some time
        // execute
        run = 0;
        rst = 1;
        lsb = 0;
        #20; // Wait for some time
        rst = 0;
        run = 1;
        lsb = 0;

        // Generate clock cycles
        repeat (200) begin
            #5; // Change this delay value according to your desired clock period
            if (rdy) begin
                run = 0; // Stop running when rdy is high
                #5 
                rst = 1; // Reset the system
                #10
                rst = 0; // Release the reset
                run = 1; // Start running again
            end

        end

        repeat (200) begin
            #20; // Change this delay value according to your desired clock period
            lsb = ~lsb; // Toggle lsb every 20 lock cycle
        end

        // End simulation
        $finish;
    end

    // Display results
    always @(posedge clk) begin
        $display("Time: %t, rdy: %b, SLL_ctrl: %b, SRL_ctrl: %b, w_ctrl_reg1: %b, w_ctrl_reg2: %b, funct: %b", $time, rdy, SLL_ctrl, SRL_ctrl, w_ctrl_reg1, w_ctrl_reg2, funct);
    end

endmodule


