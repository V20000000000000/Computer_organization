/*
 *	Template for Project 2 Part 3
 *	Copyright (C) 2023  Hsiu-Yi Ou Yang or any person belong ESSLab.
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
module SimpleCPU(
	// Outputs
	output	wire	[31:0]	Output_Addr,
	// Inputs
	input	wire	[31:0]	Input_Addr,
	input	wire			clk
);

wire [31:0] instructionWire;
wire [31:0] rt_data_wire;
wire [31:0] rs_data_wire;
wire [31:0] rd_data_wire;
wire [31:0] sign_extended_imm_wire;
wire [31:0]	ALU_sccB_wire;
wire [31:0] ALU_result_wire;
wire [31:0] Next_PC_wire;
wire [31:0] BranchOffset_wire;
wire [31:0] BranchAddr_wire;
wire [31:0] notJumpAddr_wire;
wire [31:0] JumpAddr_wire;
wire [31:0] Mem_r_data_wire;
wire [27:0] JumpOffsetAddr_wire;
wire [5:0] Funct_wire;
wire [4:0] rd_addr_wire;
wire Reg_dst_wire;
wire Branch_wire;
wire Reg_w_wire;
wire [1:0] ALU_op_wire;
wire ALU_src_wire;
wire Mem_w_wire;
wire Mem_r_wire;
wire Mem_to_reg_wire;
wire Jump_wire;
wire zero_wire;
wire isBranch_wire;

	Adder PC_Adder(
		.A(Input_Addr),	// PC
		.B(4),	// 4
		.Sum(Next_PC_wire)	// Next PC
	);

	Adder Branch_Adder(
		.A(Next_PC_wire),	// Next PC
		.B(BranchOffset_wire),	// Instruction
		.Sum(BranchAddr_wire)	// Output
	);

	AndGate BranchAndGate(
		.A(Branch_wire),	// Branch
		.B(zero_wire),	// zero
		.Y(isBranch_wire)	// Output
	);

	ShiftLeft_32to32bits BranchImmShiftLeft(
		.inputData(sign_extended_imm_wire),	// Next PC
		.outputData(BranchOffset_wire)	// Instruction
	);

	ShiftLeft_26to28bits JumpShiftLeft(
		.inputData(instructionWire[25:0]),	// Next PC
		.outputData(JumpOffsetAddr_wire)	// Instruction
	);

	assign JumpAddr_wire = {Next_PC_wire[31:28], JumpOffsetAddr_wire};

	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		.Instr_addr(Input_Addr),	// Address
		.Instruction(instructionWire)	// Instruction
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		.rs_addr(instructionWire[25:21]),	// rs
		.rt_addr(instructionWire[20:16]),	// rt
		.rd_addr(rd_addr_wire),
		.rd_data(rd_data_wire),
		.reg_write(Reg_w_wire),
		.clk(clk),
		.rs_data(rs_data_wire),
		.rt_data(rt_data_wire)
	);

	MUX_5bit MUX_Reg_dst(
		.A(instructionWire[20:16]),	// rt
		.B(instructionWire[15:11]),	// rd
		.S(Reg_dst_wire),	// Reg_dst
		.Y(rd_addr_wire)	// Output
	);

	MUX_32bit MUX_ALU_src(
		.A(rt_data_wire),	// rs_data
		.B(sign_extended_imm_wire),	// imm
		.S(ALU_src_wire),	// ALU_src
		.Y(ALU_sccB_wire)	// Output
	);

	MUX_32bit MUX_isBranch(
		.A(Next_PC_wire),	// ALU_result
		.B(BranchOffset_wire),	// rt_data
		.S(isBranch_wire),	// Mem_to_reg
		.Y(notJumpAddr_wire)	// Output
	);

	MUX_32bit MUX_isJump(
		.A(notJumpAddr_wire),	// ALU_result
		.B(JumpAddr_wire),	// rt_data
		.S(Jump_wire),	// Mem_to_reg
		.Y(Output_Addr)	// Output
	);

	MUX_32bit MUX_Mem_to_reg(
		.A(ALU_result_wire),	// ALU_result
		.B(Mem_r_data_wire),	// rt_data
		.S(Mem_to_reg_wire),	// Mem_to_reg
		.Y(rd_data_wire)	// Output
	);

	ALU ALU_Unit(
		.srcA(rs_data_wire),
		.srcB(ALU_sccB_wire),
		.funct(Funct_wire),
		.shamt(instructionWire[10:6]),
		.result(ALU_result_wire),
		.zero(zero_wire)
	);

	ALUControl ALU_Control_Unit(
		.Funct_ctrl(instructionWire[5:0]),	// Funct
		.ALU_op(ALU_op_wire),	// ALU_op
		.Funct(Funct_wire)	// Output
	);

	SignExtender Sign_Extender(
		.inputData(instructionWire[15:0]),	// imm
    	.outputData(sign_extended_imm_wire)	// Output
	);

	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
		.Mem_addr(ALU_result_wire),	// Address
		.Mem_w_data(rt_data_wire),	// Data
		.Mem_w(Mem_w_wire),		// Write enable
		.Mem_r(Mem_r_wire),		// Read enable
		.clk(clk),		// Clock
		.Mem_r_data(Mem_r_data_wire)	// Data
	);

	Control Control_Unit(
		.Opcode(instructionWire[31:26]),
		.Reg_dst(Reg_dst_wire),
		.Branch(Branch_wire),
		.Reg_w(Reg_w_wire),
		.ALU_op(ALU_op_wire),
		.ALU_src(ALU_src_wire),
		.Mem_w(Mem_w_wire),
		.Mem_r(Mem_r_wire),
		.Mem_to_reg(Mem_to_reg_wire),
		.Jump(Jump_wire)
	);

endmodule
