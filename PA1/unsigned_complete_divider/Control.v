
module Control (
    output reg rdy,
    output reg w_ctrl_reg1,
    output reg adding_ctrl,
    output reg [5:0] ALU_control,
    output reg w_ctrl_reg2,
    input run,
    input rst,
    input clk,
    input lsb
);

    parameter ALU_function = 6'b001010;

    reg [5:0] count;

    always @(posedge rst or posedge clk)
    begin
        if(rst)
        begin
            rdy <= 0;
            ALU_control = ALU_function;
            w_ctrl_reg1 <= 0;   // 0: load multiplicand
            w_ctrl_reg2 <= 0;
            count <= 0;
        end
        else
        begin
            if (run)
            begin
                count <= count + 1;
                if(count == 32)
                begin
                    begin
                    rdy <= 1;
                    end
                end
                else
                begin
                    w_ctrl_reg1 <= 1;
                    w_ctrl_reg2 <= 1;
                    if(lsb)
                    begin
                        adding_ctrl <= 1;
                    end
                    else
                    begin
                        adding_ctrl <= 0;
                    end
                end
            end
        end
    end

endmodule