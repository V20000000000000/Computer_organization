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
 *	This file is for people who have taken the cource (1102 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */
 
/*
 * Macro of size declaration of data memory
 * CAUTION: DONT MODIFY THE NAME AND VALUE.
 */
`define DATA_MEM_SIZE	128	// Bytes

/*
 * Declaration of Data Memory for this project.
 * CAUTION: DONT MODIFY THE NAME.
 */
module DM(
	// Outputs
	output [31:0] Mem_r_data,
	// Inputs
	input [31:0] Mem_w_data,
	input [31:0] Mem_addr,
	input Mem_w, Mem_r, clk
);

	/* 
	 * Declaration of data memory.
	 * CAUTION: DONT MODIFY THE NAME AND SIZE.
	 */
	reg [7:0]DataMem[0:`DATA_MEM_SIZE - 1];

	// read data from data memory
	assign Mem_r_data = Mem_r ? {DataMem[Mem_addr[6:0]], DataMem[Mem_addr[6:0]+1], DataMem[Mem_addr[6:0]+2], DataMem[Mem_addr[6:0]+3]} : 32'b0;

	// write data to data memory
	always @(negedge clk)
	begin
		if(Mem_w)
		begin
			DataMem[Mem_addr[6:0]] <= Mem_w_data[31:24];
			DataMem[Mem_addr[6:0]+1] <= Mem_w_data[23:16];
			DataMem[Mem_addr[6:0]+2] <= Mem_w_data[15:8];
			DataMem[Mem_addr[6:0]+3] <= Mem_w_data[7:0];
		end
	end

endmodule
