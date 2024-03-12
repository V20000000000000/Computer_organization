`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/12 20:40:52
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] Src_1,
    input [31:0] Src_2,
    input [5:0] Funct,
    input [4:0] shamt,
    output [31:0] ALU_result,
    output [0:0] Zero,
    output [0:0] Carry
    );

    reg [31:0] ALU_result_reg;

    always @(Src_1 or Src_2 or Funct)
    begin
        if(Funct == 001001)
        begin
            ALU_result_reg <= Src_1 + Src_2;
        end
        else if(Funct == 001010)
        begin
            ALU_result_reg <= Src_1 - Src_2;
        end
        else if(Funct == 010001)
        begin
            ALU_result_reg <= Src_1 & Src_2;
        end
        else if(Funct == 100010)
        begin
            ALU_result_reg <= Src_1 >> shamt;
        end
        else if(Funct == 100110)
    end    
endmodule
