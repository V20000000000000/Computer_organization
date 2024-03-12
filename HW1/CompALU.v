
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

    wire [31:0]Inner_Src_1;
    wire [31:0]Inner_Src_2;

    RF Register_File(
    .Rs_addr(Instruction[25:21]),
    .Rt_addr(Instruction[20:16]),
    .Rs_data(Inner_Src_1),
    .Rt_data(Inner_Src_2)
    );

    ALU Arithmatic_Logical_Unit(
    .Src_1(Inner_Src_1),
    .Src_2(Inner_Src_2),
    .Shamt(Instruction[10:6]),
    .Funct(Instruction[5:0]),
    .ALU_result(CompALU_data),
    .Zero(CompALU_zero),
    .Carry(CompALU_carry)
    );


endmodule
