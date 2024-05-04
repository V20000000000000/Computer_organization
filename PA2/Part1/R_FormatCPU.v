/*
 *	Template for Project 2 Part 1
 *	Copyright (C) 2022  Chen Chia Yi or any person belong ESSLab.
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
 *	This file is for people who have taken the cource (1102 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module R_FormatCPU(
	// Outputs
	output	wire	[31:0]	Output_Addr,
	// Inputs
	input	wire	[31:0]	Input_Addr,
	input	wire			clk
);

wire [31:0] instructionWire;
wire [31:0] rs_data;
wire [31:0] rt_data;
wire [31:0] rd_data;
wire [5:0] Funct;
wire [1:0] ALU_op;
wire reg_write;


	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		.Instr_addr(Input_Addr),
		.Instruction(instructionWire)
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		.rs_addr(instructionWire[25:21]),
		.rt_addr(instructionWire[20:16]),
		.rd_addr(instructionWire[15:11]),
		.rd_data(rd_data),
		.reg_write(reg_write),
		.clk(clk),
		.rs_data(rs_data),
		.rt_data(rt_data)
	);

	ALU ALU_Unit(
		.rs_data(rs_data),
		.rt_data(rt_data),
		.funct(Funct),
		.shamt(instructionWire[10:6]),
		.result(rd_data)
	);

	Adder Adder_Unit(
		.inputAddr(Input_Addr),
		.inputOffset(4),
		.outputAddr(Output_Addr)
	);

	ALU_Control ALU_Control_Unit(
		.ALU_op(ALU_op),
		.Funct_ctrl(instructionWire[5:0]),
		.Funct(Funct)
	);

	Control Control_Unit(
		.Opcode(instructionWire[31:26]),
		.ALU_op(ALU_op),
    	.Reg_w(reg_write)
	);

endmodule
