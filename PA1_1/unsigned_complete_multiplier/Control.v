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

    reg [4:0] count;
    reg [1:0] state;


    always @(posedge rst or posedge clk)
    begin
        if(rst)
        begin
            rdy <= 0;
            w_ctrl_Multiplicand <= 0;
            adding_ctrl <= 0;
            addu_ctrl <= 6'b000000;
            w_ctrl_Product <= 0;
        end
        else
        begin
            if (run)
            begin
                addu_ctrl <= 6'b001001; // ALU function: add
                state <= 0;
                case(state)
                    0:  // initialize, loading values
                    begin
                        w_ctrl_Multiplicand <= 1;   // load multiplicand
                        w_ctrl_Product <= 0;    // load product
                        rdy <= 0;  // not ready
                        adding_ctrl <= 0;   // product not adding
                        count <= 5'b00000;
                        state <= 1;
                    end
                    1:  // execute product
                    begin
                        w_ctrl_Multiplicand <= 0;   // not load multiplicand
                        w_ctrl_Product <= 1;    // execute product
                        if (lsb)
                        begin
                            adding_ctrl <= 1;   // product adding
                        end
                        else
                        begin
                            adding_ctrl <= 0;   // product not adding
                        end
                        count <= count + 1;
                        state <= 2;
                    end
                    2:
                    begin
                        if (count == 5'b00000)
                        begin
                            state <= 1;
                        end
                        else
                        begin
                            rdy <= 1;  // ready
                            state <= 0;
                        end
                    end
                endcase
            end
            else
            begin
                rdy <= 0;
                w_ctrl_Multiplicand <= 0;
                adding_ctrl <= 0;
                addu_ctrl <= 6'b000000;
                w_ctrl_Product <= 0;
            end
        end
    end

endmodule