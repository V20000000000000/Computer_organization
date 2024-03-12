`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/12 20:42:27
// Design Name: 
// Module Name: CompALU
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


module CompALU(
    input [31:0] Instruction,
    output [31:0] CompALU_data,
    output CompALU_zero,
    output CompALU_carry
    );

    wire [31:0]Rs_data_wire;
    wire [31:0]Rt_data_wire;

    RF RF(
    .Rs_addr(Instruction[25:21]),
    .Rt_addr(Instruction[20:16]),
    .Rs_data(Rs_data_wire),
    .Rt_data(Rt_data_wire)
    );

    ALU ALU(
    .Src_1(Rs_data_wire),
    .Src_2(Rt_data_wire),
    .Funct(Instruction[5:0]),
    .shamt(Instruction[10:6]),
    .ALU_result(CompALU_data),
    .Zero(CompALU_zero),
    .Carry(CompALU_carry)
    );


endmodule
