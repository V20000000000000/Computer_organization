/*
 *	Template for Project 3 Part 2
 *	Copyright (C) 2024 Shi Chen Lin or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module I_PipelineCPU(
	// Outputs
	output [31:0] Output_Addr,
	// Inputs
	input  [31:0] Input_Addr,
	input  clk
);

	wire [31:0] instruction_in_wire;
	wire [31:0] instruction_out_wire;
	wire [31:0] Rs_data_wire1, Rs_data_wire2;
	wire [31:0] Rt_data_wire1, Rt_data_wire2;
	wire [31:0] Rd_data_wire1, Rd_data_wire2, Rd_data_wire3, Rd_data_wire4;
	wire [31:0] Imm_wire1, Imm_wire2;
	wire [31:0] src2_wire;
	wire [31:0] ALU_result_wire2, ALU_result_wire3, ALU_result_wire4;
	wire [31:0] Mem_w_data_wire;
	wire [31:0] Mem_r_data_wire3, Mem_r_data_wire4;
	wire [5:0] Funct_wire;
	wire [4:0] Rd_addr_wire1, Rd_addr_wire2, Rd_addr_wire2_1, Rd_addr_wire3, Rd_addr_wire4;
	wire [1:0] ALU_op_wire1, ALU_op_wire2;
	wire Reg_dst_wire1, Reg_dst_wire2;
	wire Mem_to_reg_wire1, Mem_to_reg_wire2, Mem_to_reg_wire3, Mem_to_reg_wire4;
	wire Reg_w_wire1, Reg_w_wire2, Reg_w_wire3, Reg_w_wire4;
	wire Mem_w_wire1, Mem_w_wire2, Mem_w_wire3;
	wire Mem_r_wire1, Mem_r_wire2, Mem_r_wire3;
	wire ALU_src_wire1, ALU_src_wire2;

	/* 
	 * Declaration of Adder.
	 * CAUTION: DONT MODIFY THE NAME.
	 */

	Adder Adder(
		// Outputs
		.output_Addr(Output_Addr),
		// Inputs
		.input_Addr(Input_Addr),
		.input_Offset(32'b00000000000000000000000000000100)
	);

	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.Instruction(instruction_in_wire),
		// Inputs
		.Instr_addr(Input_Addr)
	);

	/* 
	 * Declaration of IF/ID.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IF_ID IF_ID(
		// Outputs
		.Instruction_ID(instruction_out_wire),
		// Inputs
		.Instruction(instruction_in_wire).
		.clk(clk)
	);

	/* 
	 * Declaration of Control.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Control Control(
		// Outputs
		.Reg_dst(Reg_dst_wire1),
		.Reg_w(Reg_w_wire1),
		.Mem_to_reg(Mem_to_reg_wire1),
		.Mem_w(Mem_w_wire1),
		.Mem_r(Mem_r_wire1),
		.ALU_op(ALU_op_wire1),
		.ALU_src(ALU_op_wire2),
		// Inputs
		.OpCode(instruction_out_wire[31:26]),
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.Rs_data(Rs_data_wire1),
		.Rt_data(Rt_data_wire1),
		// Inputs
		.Rd_data(Rd_data_wire4),
		.Rs_addr(instruction_out_wire[25:21]),
		.Rt_addr(instruction_out_wire[20:16]),
		.Rd_addr(Rd_addr_wire4),
		.Reg_w(Reg_w_wire4),
		.clk(clk)
	);

	/* 
	 * Declaration of SignExtender.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	SignExtender SignExtender1(
		// Outputs
		.outputData(Imm_wire1),
		// Inputs
		.inputData(instruction_out_wire[15:0])
	);

	/* 
	 * Declaration of ID_EX.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	ID_EX ID_EX(
		// Outputs
		.Rs_data_out(Rs_data_wire2),
		.Rt_data_out(Rt_data_wire2),
		.Imm_out(Imm_wire2),
		.Rd_addr_out(Rd_addr_wire2),
		.Rt_addr_out(Rt_addr_wire2),
		.ALU_op_out(ALU_op_wire2),
		.Reg_w_out(Reg_w_wire2),
		.Reg_dst_out(Reg_dst_wire2),
		.ALU_src_out(ALU_src_wire2),
		.Mem_w_out(Mem_w_wire2),
		.Mem_r_out(Mem_r_wire2),
		.Mem_to_reg_out(Mem_to_reg_wire2),
		// Inputs
		.Rs_data_in(Rs_data_wire1),
		.Rt_data_in(Rt_data_wire1),
		.Imm_in(Imm_wire1),
		.Rd_addr_in(instruction_out_wire[15:11]),
		.Rt_addr_in(instruction_out_wire[20:16]),
		.ALU_src_in(ALU_src_wire1),
		.Reg_w_in(Reg_w_wire1),
		.Reg_dst_in(Reg_dst_wire1),
		.Mem_w_in(Mem_w_wire1),
		.Mem_r_in(Mem_r_wire1),
		.Mem_to_reg_in(Mem_to_reg_wire1),
		.clk(clk)
	);

	/* 
	 * Declaration of ALU_src MUX_32bit.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	ALU_src MUX_32bit(
		// Outputs
		.Y(src2_wire),
		// Inputs
		.A(Rt_data_wire2),
		.B(Imm_wire2),
		.S(ALU_src_wire2)
	);

	/* 
	 * Declaration of ALU.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	ALU ALU(
		// Outputs
		.result(ALU_result_wire2),
		// Inputs
		.srcA(Rs_data_wire2),
		.srcB(src2_wire),
		.funct(Funct_wire),
		.shamt(instruction_out_wire[10:6])
	);

	/* 
	 * Declaration of Reg_dst MUX_5bit.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Reg_dst MUX_5bit(
		// Outputs
		.Y(Rd_addr_wire2_1),
		// Inputs
		.A(Rt_addr_wire2),
		.B(Rd_addr_wire2),
		.S(Reg_dst_wire2)
	);

	/* 
	 * Declaration of ALU_Control.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	ALU_Control ALU_Control(
		// Outputs
		.Funct(Funct_wire),
		// Inputs
		.Funct_ctrl(Imm_wire2[5:0]),
		.ALU_op(ALU_op_wire2)
	);

	/* 
	 * Declaration of EX_MEM.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	EX_MEM EX_MEM(
		// Outputs
		.ALU_result_out(ALU_result_wire3),
		.Mem_w_data_out(Mem_w_data_wire),
		.Rd_addr_out(Rd_addr_wire3),
		.Mem_w_out(Mem_w_wire3),
		.Mem_r_out(Mem_r_wire3),
		.Mem_to_reg_out(Mem_to_reg_wire3),
		.Reg_w_out(Reg_w_wire3),
		// Inputs
		.ALU_result_in(ALU_result_wire2),
		.Mem_w_data_in(Rt_data_wire2),
		.Rd_addr_in(Rd_addr_wire2_1),
		.Mem_w_in(Mem_w_wire2),
		.Mem_r_in(Mem_r_wire2),
		.Mem_to_reg_in(Mem_to_reg_wire2),
		.Reg_w_in(Reg_w_wire2),
		.clk(clk)
	);

	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
		// Outputs
		.Mem_r_data(Mem_r_data_wire3),
		// Inputs
		.Mem_w_data(Mem_w_data_wire),
		.Mem_addr(ALU_result_wire3),
		.Mem_w(Mem_w_wire3),
		.Mem_r(Mem_r_wire3),
		.clk(clk)
	);

	/* 
	 * Declaration of MEM_WB.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	MEM_WB MEM_WB(
		// Outputs
		.ALU_result_out(ALU_result_wire4),
		.Mem_r_data_out(Mem_r_data_wire4),
		.Rd_addr_out(Rd_addr_wire4),
		.Mem_to_reg_out(Mem_to_reg_wire4),
		.Reg_w_out(Reg_w_wire4),
		// Inputs
		.ALU_result_in(ALU_result_wire3),
		.Mem_r_data_in(Mem_r_data_wire3),
		.Rd_addr_in(Rd_addr_wire3),
		.Mem_to_reg_in(Mem_to_reg_wire3),
		.Reg_w_in(Reg_w_wire3),
		.clk(clk)
	);

	/* 
	 * Declaration of Mem_to_reg MUX_32bit.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Mem_to_reg MUX_32bit(
		// Outputs
		.Y(Rd_data_wire4),
		// Inputs
		.A(ALU_result_wire4),
		.B(Mem_r_data_wire4),
		.S(Mem_to_reg_wire4)
	);

endmodule
