/*
 *	Template for Project 3 Part 1
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
module R_PipelineCPU(
	// Outputs
	output [31:0] Output_Addr,
	// Inputs
	input  [31:0] Input_Addr,
	input         clk
);

	wire [31:0] instruction_in_wire;
	wire [31:0] instruction_out_wire;
	wire [31:0] Rs_data_wire1;
	wire [31:0] Rs_data_wire2;
	wire [31:0] Rt_data_wire1;
	wire [31:0] Rt_data_wire2;
	wire [31:0] Rd_data_wire2;
	wire [31:0] ALU_result_wire;
	wire [4:0] Rd_addr_wire1;
	wire Regw_wire4;
	wire Regw_wire3;
	wire Regw_wire2;
	wire Regw_wire1;
	wire [1:0] ALU_op_wire1;
	wire [1:0] ALU_op_wire2;
	wire [4:0] Rd_addr_wire1;
	wire [5:0] Funct_ctrl_wire;
	wire [4:0] shamt_wire;	
	wire [5:0] Funct_wire;



	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.Instruction(),
		// Inputs
		.Instr_addr(Input_Addr)
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
		.Rd_data(Rd_data_wire2),
		.Rs_addr(instruction_out_wire[25:21]),
		.Rt_addr(instruction_out_wire[20:16]),
		.Rd_addr(instruction_out_wire[15:11]),
		.Reg_w(Regw_wire4),
		.clk(clk)
	);

	/* 
	 * Declaration of IF_ID.
	 */
	IF_ID IF_ID(
		// Outputs
		.Instruction_ID(instruction_out_wire),
		// Inputs
		.Instruction(instruction_in_wire),
		.clk(clk)
	);

	/* 
	 * Declaration of Control.
	 */

	Control Control(
		// Outputs
		.Reg_w(Regw_wire1),
		.ALU_op(ALU_op_wire1),
		// Inputs
		.Instruction(instruction_out_wire[31:26])
	);
	
	/* 
	 * Declaration of ID_EX.
	 */
	ID_EX ID_EX(
		// Outputs
		.Rs_data_out(Rs_data_wire2),
		.Rt_data_out(Rt_data_wire2),
		.Funct_ctrl_out(Funct_ctrl_wire),
		.shamt_out(shamt_wire),
		.Rd_addr_out(Rd_addr_wire1),
		.ALU_op_out(ALU_op_wire2),
		.Reg_w_out(Regw_wire2),
		// Inputs
		.Rs_data_in(Rs_data_wire1),
		.Rt_data_in(Rt_data_wire1),
		.ALU_op_in(ALU_op_wire1),
		.Funct_ctrl_in(instruction_out_wire[5:0]),
		.shamt_in(instruction_out_wire[10:6]),
		.Rd_addr_in(instruction_out_wire[15:11]),
		.Reg_w_in(Regw_wire1),
		.clk(clk)
	);

	/* 
	 * Declaration of ALU.
	 */
	ALU ALU(
		// Outputs
		.result(ALU_result_wire),
		// Inputs
		.funct(Funct_wire),
		.rs_data(Rs_data_wire2),
		.rt_data(Rt_data_wire2),
		.shamt(shamt_wire)
	);

	/* 
	 * Declaration of ALU_Control.
	 */
	ALU_Control ALU_Control(
		// Outputs
		.Funct(Funct_wire),
		// Inputs
		.ALU_op(ALU_op_wire2),
		.Funct_ctrl(Funct_ctrl_wire)
	);


endmodule
