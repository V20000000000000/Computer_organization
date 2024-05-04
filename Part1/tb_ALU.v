`timescale 1ns / 1ps

module ALU_tb;

    // Declare signals
    reg [31:0] rs_data;
    reg [31:0] rt_data;
    reg [5:0] funct;
    reg [4:0] shamt;
    wire [31:0] result;

    // Instantiate the ALU module
    ALU dut (
        .rs_data(rs_data),
        .rt_data(rt_data),
        .funct(funct),
        .shamt(shamt),
        .result(result)
    );

    // Stimulus generation
    initial begin
        // Test case 1: ADDU
        rs_data = 10;
        rt_data = 20;
        funct = `ADDU;
        shamt = 0;
        #10; // Wait for 10 time units
        $display("Result of ADDU: %d", result);

        // Test case 2: SUBU
        rs_data = 30;
        rt_data = 10;
        funct = `SUBU;
        shamt = 0;
        #10; // Wait for 10 time units
        $display("Result of SUBU: %d", result);

        // Test case 3: SLL
        rs_data = 5;
        rt_data = 0; // Not used for SLL
        funct = `SLL;
        shamt = 2;
        #10; // Wait for 10 time units
        $display("Result of SLL: %d", result);

        // Test case 4: SLLV
        rs_data = 8;
        rt_data = 2;
        funct = `SLLV;
        shamt = 0; // Not used for SLLV
        #10; // Wait for 10 time units
        $display("Result of SLLV: %d", result);

        // End simulation
        $finish;
    end

endmodule
