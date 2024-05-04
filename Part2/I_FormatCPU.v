/*
 *	Template for Project 2 Part 2
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
module I_FormatCPU(
	// Outputs
	output	wire	[31:0]	Output_Addr,
	// Inputs
	input	wire	[31:0]	Input_Addr,
	input	wire			clk
);

wire [31:0] InstructionWire;
wire [31:0] Rd_data_wire;
wire [31:0] Rs_data_wire;
wire [31:0] Rt_data_wire;
wire [31:0] ALU_result_wire;
wire [31:0] ALU_srcB_wire;
wire [31:0] Mem_r_data_wire;
wire [31:0] Sign_extended_wire;
wire [5:0] Funct;
wire [4:0] Rd_addr_wire;
wire [1:0] ALU_op_wire;
wire Reg_dst_wire;
wire Reg_w_wire;
wire ALU_src_wire;
wire Mem_w_wire;
wire Mem_r_wire;
wire Mem_to_reg_wire;


	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		.Instr_addr(Input_Addr),	// Address
		.Instruction(InstructionWire) // Instruction
	);

	Adder Adder(
		.inputAddr(Input_Addr),
		.inputOffset(4),
		.outputAddr(Output_Addr)
	);

	MUX_5bit Reg_dst(
		.A(InstructionWire[20:16]),
		.B(InstructionWire[15:11]),
		.S(Reg_dst_wire),
		.Y(Rd_addr_wire)
	);

	MUX_32bit ALU_src(
		.A(Rt_data_wire),
		.B(Sign_extended_wire),
		.S(ALU_src_wire),
		.Y(ALU_srcB_wire)
	);

	MUX_32bit Mem_to_Reg(
		.A(ALU_result_wire),
		.B(Mem_r_data_wire),
		.S(Mem_to_reg_wire),
		.Y(Rd_data_wire)
	);

	Sign_Extend Sign_Extend(
		.input(InstructionWire[15:0]),
		.output(Sign_extended_wire)
	);

	ALU ALU(
		.srcA(Rs_data_wire),
		.srcB(ALU_srcB_wire),
		.funct(Funct),
		.shamt(InstructionWire[10:6]),
		.result(ALU_result_wire)
	);

	ALU_Control ALU_Control(
		.Funct_ctrl(InstructionWire[5:0]),
		.ALU_op(ALU_op_wire),
		.Funct(Funct)
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		.rs_addr(InstructionWire[25:21]), // rs_addr
		.rt_addr(InstructionWire[20:16]), // rt_addr
		.rd_addr(Rd_addr_wire), // rd_addr
		.rd_data(Rd_data_wire), // rd_data
		.reg_write(Reg_w_wire),
		.clk(clk),
		.rs_data(Rs_data_wire),
		.rt_data(Rt_data_wire)
	);

	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
		.Mem_addr(ALU_result_wire),	// Address
		.Mem_w_data(Rt_data_wire),	// Data
		.Mem_w(Mem_w_wire),		// Write enable
		.Mem_r(Mem_r_wire),		// Read enable
		.clk(clk),		// Clock
		.Mem_r_data(Mem_r_data_wire)	// Data
	);

	Control Control(
		.Opcode(InstructionWire[31:26]),
		.Reg_dst(Reg_dst_wire),
		.Reg_w(Reg_w_wire),
		.ALU_op(ALU_op_wire),
		.ALU_src(ALU_src_wire),
		.Mem_w(Mem_w_wire),
		.Mem_r(Mem_r_wire),
		.Mem_to_reg(Mem_to_reg_wire)
	);

endmodule
