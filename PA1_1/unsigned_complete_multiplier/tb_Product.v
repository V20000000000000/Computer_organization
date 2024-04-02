module tb_Product;

    // Inputs
    reg [31:0] alu_result;
    reg alu_carry;
    reg [31:0] multiplier_in;
    reg adding_ctrl;
    reg w_ctrl_Product;
    reg rdy;
    reg rst;
    reg clk;

    // Outputs
    wire [63:0] product_out;
    wire [31:0] hi;
    wire lsb;

    // Instantiate the Product module
    Product uut (
        .product_out(product_out),
        .hi(hi),
        .alu_result(alu_result),
        .alu_carry(alu_carry),
        .multiplier_in(multiplier_in),
        .adding_ctrl(adding_ctrl),
        .w_ctrl_Product(w_ctrl_Product),
        .lsb(lsb),
        .rdy(rdy),
        .rst(rst),
        .clk(clk)
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
        w_ctrl_Product = 0;
        #20; // Wait for some time
        // execute
        rst = 1;
        #20; // Wait for some time
        rst = 0;
        adding_ctrl = 1;
        multiplier_in = 32'h10000000;
        alu_carry = 0;

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
            end
        end

        repeat (200) begin
            #20; // Change this delay value according to your desired clock period
            alu_carry <= ~alu_carry; // Toggle lsb every 20 lock cycle
        end

        repeat (200) begin
            #30;
            adding_ctrl <= ~adding_ctrl;
        end

        repeat (200) begin
            #50;
            w_ctrl_Product <= ~w_ctrl_Product;
        end

        // Display results
        $display("Time: %0t, hi: %h, product_out: %h, lsb: %b", $time, hi, product_out, lsb);

        // End simulation
        $finish;
    end

endmodule


