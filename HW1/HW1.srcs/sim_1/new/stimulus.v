`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/07 15:49:27
// Design Name: 
// Module Name: stimulus
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stimulus(
    );
    reg clk;
    reg reset;
    wire[3:0] q;
    
    // instantiate the design block
    ripple r1(q, clk, reset);
    
    // Control the clk signal that drives the design block.
    initial clk = 1'b0;
    always #5 clk = ~clk;
    
    // Control the reset signal that drives the design block
    initial
    begin
    reset = 1'b1;
    #15 reset = 1'b0;
    #180 reset = 1'b1;
    #10 reset = 1'b0;
    #20 $stop;
    end
    
    // Monitor the outputs 
    initial
        $monitor($time, " Output q = %d",  q);
    
    //Waveforms
    /*
    initial
        $gr_waves("clock", clk,
                            "reset",reset,
                            "q[0]",q[0],
                            "q[1]",q[1],
                            "q[2]",q[2],
                            "q[3]",q[3]
                            );
    */
endmodule
