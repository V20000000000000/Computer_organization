module Control (
    output reg rdy,
    output reg w_ctrl_Multiplicand,
    output reg adding_ctrl,
    output reg [5:0] addu_ctrl,
    output reg w_ctrl_Product,
    input run,
    input rst,
    input clk,
    input lsb
);

    reg [5:0] count;

    always @(posedge rst or posedge clk)
    begin
        if(rst)
        begin
            rdy <= 0;
            addu_ctrl = 6'b001001;
            w_ctrl_Multiplicand <= 0;   // 0: load multiplicand
            w_ctrl_Product <= 0;
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
                    w_ctrl_Multiplicand <= 1;
                    w_ctrl_Product <= 1;
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