module Remainder (
    output [63:0] reg2_out,  
    output [31:0] hi,
    input [31:0] alu_result,
    input alu_carry,
    input [31:0] reg2_in, 
    input [1:0] w_ctrl_reg2,
    input sign_flag,
    input rdy,
    input rst,
    input clk
);

    reg [64:0] reg2;

    always @(posedge rst or negedge clk)
    begin
        if(rst)
        begin
            reg2 <= 65'b0;
        end
        else
        begin
            case(w_ctrl_reg2)
                2'b00:  // load and shift left
                    begin
                        reg2 <= {32'h00000000, reg2_in, 1'b0};
                    end
                2'b01:  // Subtract Divisor from the left half Remainder register, and place in the left half Remainder register
                    begin
                        reg2[64:32] <= {alu_carry, alu_result};
                    end
                2'b10:  // shift left, setting rightmost bit to 1
                    begin
                        reg2 <= {reg2[63:0], 1'b1};
                    end
                2'b11:  // Restore original value by adding Divisor to left half Remainder, and place sum in left half Remainder. 
                    begin   // Also shift Remainder left, setting rightmost bit to 0
                        reg2[64:32] <= {alu_carry, alu_result};
                        reg2 <= {reg2[63:0], 1'b0};
                    end
            endcase
        end
    end

    assign hi = reg2[63:32];
    assign reg2_out = reg2[63:0];
    assign sign_flag = reg2[65];

endmodule