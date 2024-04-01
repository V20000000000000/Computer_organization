module tb_Remainder;

    // Inputs
    reg [31:0] alu_result;
    reg alu_carry;
    reg [31:0] reg2_in;
    reg w_ctrl_reg2;
    reg SLL_ctrl;
    reg SRL_ctrl;
    reg rdy;
    reg rst;
    reg clk;
    reg run;

    // Outputs
    wire [63:0] reg2_out;
    wire [31:0] hi;

    // Instantiate the Remainder module
    Remainder uut (
        .reg2_out(reg2_out),
        .hi(hi),
        .alu_result(alu_result),
        .alu_carry(alu_carry),
        .reg2_in(reg2_in),
        .w_ctrl_reg2(w_ctrl_reg2),
        .SLL_ctrl(SLL_ctrl),
        .SRL_ctrl(SRL_ctrl),
        .rdy(rdy),
        .rst(rst),
        .clk(clk),
        .run(run)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test case generation
    initial begin
        // Initialize inputs
        rst = 1;
        alu_result = 32'h12345678;
        w_ctrl_reg2 = 0;
        SLL_ctrl = 0;
        SRL_ctrl = 0;
        run = 0;
        #20; // Wait for some time
        // execute
        rst = 1;
        #20; // Wait for some time
        rst = 0;
        alu_carry = 1;
        reg2_in = 32'h10000000;

        // Generate clock cycles
        repeat (200) begin
            #5; // Change this delay value according to your desired clock period
            begin
                rdy <= 1;
                #10;
                rdy <= 0;
                rst <= 1; 
                #10;
                rst <= 0; 
                run <= 1;
            end
        end
        #50

        repeat (200) begin
            #20; // Change this delay value according to your desired clock period
            alu_carry <= ~alu_carry; // Toggle lsb every 20 lock cycle
        end

        SRL_ctrl = 0;

        repeat (200) begin
            #30;
            SRL_ctrl <= ~SRL_ctrl;
        end

        repeat (200) begin
            #50;
            w_ctrl_reg2 <= ~w_ctrl_reg2;
        end

        repeat (200) begin
            #20; // Change this delay value according to your desired clock period
            alu_carry <= ~alu_carry; // Toggle lsb every 20 lock cycle
        end

        // Display results
        $display("Time: %0t, hi: %h, reg2_out: %h", $time, hi, reg2_out);

        // End simulation
        $finish;
    end

endmodule
