module Control (
    output reg rdy,
    output reg SLL_ctrl,
    output reg SRL_ctrl,
    output reg w_ctrl_reg1,
    output reg w_ctrl_reg2,
    input run,
    input rst,
    input clk
);

    reg [5:0] count;
    reg state;

    always @(posedge clk or posedge rst) begin
        if (rst) 
        begin
            rdy <= 0;
            SLL_ctrl <= 0;
            SRL_ctrl <= 0;
            w_ctrl_reg1 <= 0;   // 1: load reg1
            w_ctrl_reg2 <= 0;   // 1: load reg2
        end 
        else if (run) 
        begin
            state <= 0;
            count <= count + 1;
            if(count < 32)
            begin
            case(state)
            0:
                begin
                    w_ctrl_reg1 <= 1;
                    w_ctrl_reg2 <= 1;
                    SLL_ctrl <= 0;
                    SRL_ctrl <= 0;
                    state <= 1;
                end
            1:
                begin
                    rdy <= 0;
                    w_ctrl_reg1 <= 0;
                    w_ctrl_reg2 <= 0;
                    SLL_ctrl <= 1;
                    SRL_ctrl <= 0;
                    state <= 1;
                end
            endcase
            end
            else
            begin
                rdy <= 1;
                w_ctrl_reg1 <= 0;
                w_ctrl_reg2 <= 0;
                SLL_ctrl <= 0;
                SRL_ctrl <= 1;
            end
        end
    end

endmodule