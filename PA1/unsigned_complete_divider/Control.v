module Control (
    output reg rdy,
    output reg w_ctrl_reg1,
    output reg [5:0] ALU_control,
    output reg [1:0] w_ctrl_reg2,
    input run,
    input rst,
    input clk,
    input sign_flag
);
    parameter ALU_ADD = 6'b001001, ALU_SUB = 6'b001010;

    reg [5:0] count;

    always @(posedge rst or posedge clk)
    begin
        if(rst)
        begin
            rdy <= 0;
            ALU_control = 6'b000000;
            w_ctrl_reg1 <= 0;   // 0: load multiplicand
            w_ctrl_reg2 <= 2'b00;   // 00: load and shift left
            count <= 0;
        end
        else
        begin
            count <= 0;
            w_ctrl_reg1 <= 1;
            w_ctrl_reg2 <= 2'b00;   // load and shift left
            if (run)
            begin
                if(count < 32)
                begin
                    count <= count + 1;
                    w_ctrl_reg1 <= 0;
                    w_ctrl_reg2 <= 2'b01;
                    ALU_control <= ALU_SUB;
                    if(sign_flag)   // if sign_flag is 1
                    begin   // Restore original value by adding Divisor to left half Remainder, and place sum in left half Remainder.
                        w_ctrl_reg2 <= 2'b11;   // Also shift Remainder left, setting rightmost bit to 0
                        ALU_control <= ALU_ADD;
                    end
                    else    // if sign_flag is 0
                    begin   // shift left, setting rightmost bit to 1
                        w_ctrl_reg2 <= 2'b10;
                    end
                end
                else
                begin
                    rdy <= 1;
                end
            end
        end
    end

endmodule