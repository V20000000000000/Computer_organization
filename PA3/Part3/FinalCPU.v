/*
 *	Template for Project 3 Part 3
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
module FinalCPU(
	// Outputs
	output        PC_Write,
	output [31:0] Output_Addr,
	// Inputs
	input  [31:0] Input_Addr,
	input         clk
);

	wire [31:0] instruction_in_wire;
	wire [31:0] instruction_out_wire;
	wire IF_ID_write_wire;
	wire Reg_dst_wire0, Reg_dst_wire1, Reg_dst_wire2, Reg_dst_wire3, Reg_dst_wire4;
	wire Reg_w_wire0, Reg_w_wire1, Reg_w_wire2, Reg_w_wire3, Reg_w_wire4;
	wire [1:0] ALU_op_wire0, ALU_op_wire1, ALU_op_wire2, ALU_op_wire3, ALU_op_wire4;
	wire ALU_src_wire0, ALU_src_wire1, ALU_src_wire2, ALU_src_wire3, ALU_src_wire4;
	wire Mem_w_wire0, Mem_w_wire1, Mem_w_wire2, Mem_w_wire3, Mem_w_wire4;
	wire Mem_r_wire0, Mem_r_wire1, Mem_r_wire2, Mem_r_wire3, Mem_r_wire4;
	wire Mem_to_reg_wire0, Mem_to_reg_wire1, Mem_to_reg_wire2, Mem_to_reg_wire3, Mem_to_reg_wire4;
	wire isControl_wire;
	wire [31:0] Rs_data_wire1, Rs_data_wire2, Rs_data_wire3, Rs_data_wire4;
	wire [31:0] Rt_data_wire1, Rt_data_wire2, Rt_data_wire3, Rt_data_wire4;
	wire [31:0] Rd_data_wire1, Rd_data_wire2, Rd_data_wire3, Rd_data_wire4;
	wire [31:0] imm_wire1, imm_wire2;
	wire [4:0] Rd_addr_wire1, Rd_addr_wire2, Rd_addr_wire2_1, Rd_addr_wire3, Rd_addr_wire4;
	wire [4:0] Rt_addr_wire2;
	wire [4:0] Rs_addr_wire2;
	wire [31:0] ALU_src1_wire, ALU_src2_wire;
	wire [31:0] Mem_addr_wire;
	wire [31:0] ALU_result_wire, ALU_result_wire4;
	wire [1:0] Forwarding_A_wire, Forwarding_B_wire;
	wire [31:0] Mem_w_data_wire2, Mem_w_data_wire3;
	wire [31:0] Mem_r_data_wire3, Mem_r_data_wire4;
	wire [5:0] Funct_wire;

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
	 * Declaration of Adder.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Adder Adder(
		// Outputs
		.outputAddr(Output_Addr),
		// Inputs
		.inputAddr(Input_Addr),
		.inputOffset(4)
	);

	/* 
	 * Declaration of IF_TD.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IF_ID IF_TD(
		// Outputs
		.Instruction_ID(instruction_out_wire),
		// Inputs
		.Instruction(instruction_in_wire),
		.IF_ID_write(IF_ID_write_wire),
		.clk(clk)
	);

	/* 
	 * Declaration of Control.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Control Control(
		// Outputs
			.Reg_dst(Reg_dst_wire0),
    		.Reg_w(Reg_w_wire0),
    		.ALU_op(ALU_op_wire0),
    		.ALU_src(ALU_src_wire0),
    		.Mem_w(Mem_w_wire0),
    		.Mem_r(Mem_r_wire0),
    		.Mem_to_reg(Mem_to_reg_wire0),
		// Inputs
			.Opcode(instruction_out_wire[31:26])
	);

	/* 
	 * Declaration of MUX_8bit.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	MUX_8bit isControlMUX(
		// Outputs
		.Y({Reg_dst_wire1, Reg_w_wire1, ALU_op_wire1, ALU_src_wire1, Mem_w_wire1, Mem_r_wire1, Mem_to_reg_wire1}),
		// Inputs
		.A(8'b00000000),
		.B({Reg_dst_wire0, Reg_w_wire0, ALU_op_wire0, ALU_src_wire0, Mem_w_wire0, Mem_r_wire0, Mem_to_reg_wire0}),
		.S(isControl_wire)
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
	SignExtender Sign_Extender(
		// Outputs
		.outputData(imm_wire1),
		// Inputs
		.inputData(instruction_out_wire[15:0])
	);

	/* 
	 * Declaration of Hazard_detection.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Hazard_detection Hazard_detection(
		// Outputs
		.PC_Write(PC_Write),
		.isControl(isControl_wire),
		.IF_ID_write(IF_ID_write_wire),
		// Inputs
		.ID_EX_Rt_addr(Rt_addr_wire2),
		.IF_ID_Rs_addr(instruction_out_wire[25:21]),
		.IF_ID_Rt_addr(instruction_out_wire[20:16]),
		.ID_EX_MemRead(Mem_r_wire2)
	);

	/* 
	 * Declaration of ID_EX.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	ID_EX ID_EX(
		// Outputs
		.Rs_data_out(Rs_data_wire2),
		.Rt_data_out(Rt_data_wire2),
		.Imm_out(imm_wire2),
		.Rd_addr_out(Rd_addr_wire2),
		.Rt_addr_out(Rt_addr_wire2),
		.Rs_addr_out(Rs_addr_wire2),
		.ALU_op_out(ALU_op_wire2),
		.Reg_w_out(Reg_w_wire2),
		.ALU_src_out(ALU_src_wire2),
		.Reg_dst_out(Reg_dst_wire2),
		.Mem_w_out(Mem_w_wire2),
		.Mem_r_out(Mem_r_wire2),
		.Mem_to_reg_out(Mem_to_reg_wire2),
		// Inputs
		.Rs_data_in(Rs_data_wire1),
		.Rt_data_in(Rt_data_wire1),
		.Imm_in(imm_wire1),
		.Rd_addr_in(instruction_out_wire[15:11]),
		.Rt_addr_in(instruction_out_wire[20:16]),
		.Rs_addr_in(instruction_out_wire[25:21]),
		.ALU_op_in(ALU_op_wire1),
		.Reg_w_in(Reg_w_wire1),
		.ALU_src_in(ALU_src_wire1),
		.Reg_dst_in(Reg_dst_wire1),
		.Mem_w_in(Mem_w_wire1),
		.Mem_r_in(Mem_r_wire1),
		.Mem_to_reg_in(Mem_to_reg_wire1),
		.clk(clk)
	);

	/* 
	 * Declaration of ForwardingA_MUX.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	MUX_32_2bit ForwardingA_MUX(
		// Outputs
		.Y(ALU_src1_wire),
		// Inputs
		.A(Rs_data_wire2),
		.B(Rd_data_wire4),
		.C(Mem_addr_wire),
		.S(Forwarding_A_wire)
	);

	/* 
	 * Declaration of ForwardingB_MUX.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	MUX_32_2bit ForwardingB_MUX(
		// Outputs
		.Y(Mem_w_data_wire2),
		// Inputs
		.A(Rt_data_wire2),
		.B(Rd_data_wire4),
		.C(Mem_addr_wire),
		.S(Forwarding_B_wire)
	);

	MUX_32bit ALU_src_MUX(
		// Outputs
		.Y(ALU_src2_wire),
		// Inputs
		.A(Mem_w_data_wire2),
		.B(imm_wire2),
		.S(ALU_src_wire2)
	);

	/* 
	 * Declaration of ALU.
	 * CAUTION: DONT MODIFY THE NAME.
	 */

	ALU ALU(
		// Outputs
		.result(ALU_result_wire),
		// Inputs
		.srcA(ALU_src1_wire),
		.srcB(ALU_src2_wire),
		.funct(Funct_wire),
		.shamt(imm_wire2[10:6])
	);

	/* 
	 * Declaration of ALU_Control.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	ALU_Control ALU_Control(
		// Outputs
		.Funct(Funct_wire),
		// Inputs
		.ALU_op(ALU_op_wire2),
		.Funct_ctrl(imm_wire2[5:0])
	);

	/* 
	 * Declaration of Reg_dst MUX_5bit.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	MUX_5bit Reg_dst_MUX(
		// Outputs
		.Y(Rd_addr_wire2_1),
		// Inputs
		.A(Rt_addr_wire2),
		.B(Rd_addr_wire2),
		.S(Reg_dst_wire2)
	);

	/* 
	 * Declaration of Forwarding Unit Forwarding.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	Forwarding Forwarding(
		// Outputs
		.Forwarding_A(Forwarding_A_wire),
		.Forwarding_B(Forwarding_B_wire),
		// Inputs
		.Rs_addr(Rs_addr_wire2),
		.Rt_addr(Rt_addr_wire2),
		.EX_Mem_Rd_addr(Rd_addr_wire3),
		.Mem_WB_Rd_addr(Rd_addr_wire4),
		.EX_Mem_RegWrite(Reg_w_wire3),
		.Mem_WB_RegWrite(Reg_w_wire4)
	);

	/* 
	 * Declaration of EX_MEM.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	EX_MEM EX_MEM(
		// Outputs
		.ALU_result_out(Mem_addr_wire),
		.Mem_w_data_out(Mem_w_data_wire3),
		.Rd_addr_out(Rd_addr_wire3),
		.Reg_w_out(Reg_w_wire3),
		.Mem_r_out(Mem_r_wire3),
		.Mem_w_out(Mem_w_wire3),
		.Mem_to_reg_out(Mem_to_reg_wire3),
		// Inputs
		.ALU_result_in(ALU_result_wire),
		.Mem_w_data_in(Mem_w_data_wire2),
		.Rd_addr_in(Rd_addr_wire2_1),
		.Reg_w_in(Reg_w_wire2),
		.Mem_r_in(Mem_r_wire2),
		.Mem_w_in(Mem_w_wire2),
		.Mem_to_reg_in(Mem_to_reg_wire2),
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
		.Mem_w_data(Mem_w_data_wire3),
		.Mem_addr(Mem_addr_wire),
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
		.Reg_w_out(Reg_w_wire4),
		.Mem_to_reg_out(Mem_to_reg_wire4),
		// Inputs
		.ALU_result_in(Mem_addr_wire),
		.Mem_r_data_in(Mem_r_data_wire3),
		.Rd_addr_in(Rd_addr_wire3),
		.Reg_w_in(Reg_w_wire3),
		.Mem_to_reg_in(Mem_to_reg_wire3),
		.clk(clk)
	);

	/* 
	 * Declaration of Mem_to_reg MUX_32bit.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	MUX_32bit Mem_to_reg_MUX(
		// Outputs
		.Y(Rd_data_wire4),
		// Inputs
		.A(ALU_result_wire4),
		.B(Mem_r_data_wire4),
		.S(Mem_to_reg_wire4)
	);

endmodule
