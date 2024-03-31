`timescale 1ns / 1ns

module tb_ALU;

    // Inputs
    reg [31:0] src1;
    reg [31:0] src2;
    reg [5:0] funct;

    // Outputs
    wire [31:0] result;
    wire carry;

    // Instantiate the ALU module
    ALU uut (
        .result(result),
        .carry(carry),
        .src1(src1),
        .src2(src2),
        .funct(funct)
    );

    // Initialize signals
    initial begin

        // Test case 1: Subtraction (result > 0)
        src1 = 32'h00000005;
        src2 = 32'h00000004;
        funct = 6'b001010; 
        #10;

        // Test case 2: Subtraction (result < 0)
        src1 = 32'h00000001;
        src2 = 32'h00000002;
        funct = 6'b001010;
        #10;

        // Test case 3: Not subtraction function
        src1 = 32'h00000005;
        src2 = 32'h00000003;
        funct = 6'b001001;
        #10;

        // Stop simulation
        $stop;
    end

    // Display results
    always @(posedge carry) begin
        $display("src1:%h, src2:%h, funct:%h", src1, src2, funct);
        $display("result:%h, carry:%b", result, carry);
    end

endmodule


