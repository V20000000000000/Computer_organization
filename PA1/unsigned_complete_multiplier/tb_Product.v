`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/29 01:06:03
// Design Name: 
// Module Name: tb_Product
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

`timescale 1ns / 1ps

module tb_Product;

    // 定义模块输入信号
    reg [31:0] alu_result;
    reg alu_carry;
    reg [31:0] multiplier_in;
    reg adding_ctrl;
    reg [5:0] w_ctrl_Product;
    reg lsb;
    reg rdy;
    reg rst;
    reg clk;

    // 实例化 Product 模块
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

    // 时钟发生器
    always #5 clk = ~clk;

    // 初始化模块输入信号
    initial begin
        alu_result = 0;
        alu_carry = 0;
        multiplier_in = 0;
        adding_ctrl = 0;
        w_ctrl_Product = 0;
        lsb = 0;
        rdy = 1;
        rst = 1'b1; // 开始时复位为高电平
        clk = 0; // 初始时钟为低电平
    end

    // 产生复位脉冲
    always #10 rst = 1'b0;

    // 生成测试数据
    initial begin
        // 等待时钟稳定
        #20;

        // 开始测试
        // 测试用例 1: Load 操作
        alu_result = 32'd100;
        multiplier_in = 32'd50;
        w_ctrl_Product = 6'b0; // load
        rst = 1'b0; // 无复位
        #10; // 延迟以允许模块处理
        $display("Test case 1: Load operation");
        $display("alu_result = %d, multiplier_in = %d, product_out = %d", alu_result, multiplier_in, product_out);

        // 测试用例 2: Adding 操作
        alu_result = 32'd50;
        w_ctrl_Product = 6'b1; // adding
        adding_ctrl = 1'b1; // 启用加法和右移
        #10; // 延迟以允许模块处理
        $display("Test case 2: Adding operation");
        $display("alu_result = %d, adding_ctrl = %b, product_out = %d", alu_result, adding_ctrl, product_out);
        
        alu_result = 32'd50;
        w_ctrl_Product = 6'b1; // adding
        adding_ctrl = 1'b1; // 启用加法和右移
        #10; // 延迟以允许模块处理
        $display("Test case 2: Adding operation");
        $display("alu_result = %d, adding_ctrl = %b, product_out = %d", alu_result, adding_ctrl, product_out);
        
        alu_result = 32'd50;
        w_ctrl_Product = 6'b1; // adding
        adding_ctrl = 1'b1; // 启用加法和右移
        #10; // 延迟以允许模块处理
        $display("Test case 2: Adding operation");
        $display("alu_result = %d, adding_ctrl = %b, product_out = %d", alu_result, adding_ctrl, product_out);
        
        alu_result = 32'd50;
        w_ctrl_Product = 6'b1; // adding
        adding_ctrl = 1'b1; // 启用加法和右移
        #10; // 延迟以允许模块处理
        $display("Test case 2: Adding operation");
        $display("alu_result = %d, adding_ctrl = %b, product_out = %d", alu_result, adding_ctrl, product_out);
        
        alu_result = 32'd50;
        w_ctrl_Product = 6'b1; // adding
        adding_ctrl = 1'b1; // 启用加法和右移
        #10; // 延迟以允许模块处理
        $display("Test case 2: Adding operation");
        $display("alu_result = %d, adding_ctrl = %b, product_out = %d", alu_result, adding_ctrl, product_out);

        // 测试用例 3: Shifting right only
        alu_result = 32'd25;
        w_ctrl_Product = 6'b1; // adding
        adding_ctrl = 1'b1; // 禁用添加，仅右移
        #10; // 延迟以允许模块处理
        $display("Test case 3: Shifting right only");
        $display("alu_result = %d, adding_ctrl = %b, product_out = %d", alu_result, adding_ctrl, product_out);

        // 添加更多测试用例...

        // 结束仿真
        $finish;
    end
endmodule