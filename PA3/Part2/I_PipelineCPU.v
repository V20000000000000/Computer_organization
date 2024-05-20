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
	input         clk
);

	wire [31:0] instruction_in_wire;
	wire [31:0] instruction_out_wire;
	wire Reg_dst_wire1, Reg_dst_wire2;
	wire Mem_to_reg_wire3, Mem_w_wire4, Mem_r_wire5;

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
		.Reg_dst(),
		.Reg_w(),
		.Mem_to_reg(),
		.Mem_w(),
		.Mem_r(),
		.ALU_op(),
		.ALU_src(),
		// Inputs
		.OpCode(instruction_out_wire[31:26]),
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.Rs_data(),
		.Rt_data(),
		// Inputs
		.Rd_data(),
		.Rs_addr(),
		.Rt_addr(),
		.Rd_addr(),
		.Reg_w(),
		.clk()
	);

	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
		// Outputs
		.Mem_r_data(),
		// Inputs
		.Mem_w_data(),
		.Mem_addr(),
		.Mem_w(),
		.Mem_r(),
		.clk()
	);

endmodule
