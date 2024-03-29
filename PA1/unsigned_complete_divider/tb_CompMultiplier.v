/*
 *	Testbench for Project 1 Part 1
 *	Copyright (C) 2022  Han Ding Hung or any person belong ESSLab.
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
 *	NOTE	: FOR COMPATIBILITY OF YOUR CODE, PLEASE DONT CHANGE ANY THING
 *			  IN THIS FILE!
 *
 */
 
// Setting timescale
`timescale 10 ns / 1 ns

// Declarations
`define DELAY			1	// # * timescale
`define INPUT_FILE		"testbench/tb_CompMultiplier.in"
`define OUTPUT_FILE		"testbench/tb_CompMultiplier.out"

// Declaration
`define LOW		1'b0
`define HIGH	1'b1

module tb_CompMultiplier;

	// Inputs
	reg Reset;
	reg Run;
	reg [31:0] reg1_in;
	reg [31:0] reg2_in;
	
	// Outputs
	wire [63:0] reg2_out;
	wire Ready;
	
	// Clock
	reg clk = `HIGH;
	
	// Testbench variables
	reg [63:0] read_data;
	integer input_file;
	integer output_file;
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	CompMultiplier UUT(
		// Outputs
		.Prod(reg2_out),
		.Rdy(Ready),
		// Inputs
		.Mult(reg1_in),
		.Mul(reg2_in),
		.Run(Run),
		.Rst(Reset),
		.clk(clk)
	);
	
	initial
	begin : Preprocess
		// Initialize inputs
		Reset 		= `LOW;
		Run 		= `LOW;
		reg1_in	= 32'd0;
		reg2_in 	= 32'd0;

		// Initialize testbench files
		input_file	= $fopen(`INPUT_FILE, "r");
		output_file	= $fopen(`OUTPUT_FILE);

		#`DELAY;	// Wait for global reset to finish
	end
	
	always
	begin : ClockGenerator
		#`DELAY;
		clk <= ~clk;
	end
	
	always
	begin : StimuliProcess
		// Start testing
		while (!$feof(input_file))
		begin
			$fscanf(input_file, "%x\n", read_data);
			@(negedge clk);	// Wait clock
			{reg1_in, reg2_in} = read_data;
			Reset = `HIGH;
			@(negedge clk);	// Wait clock
			Reset = `LOW;
			@(negedge clk);	// Wait clock
			Run = `HIGH;
			@(posedge Ready);	// Wait ready
			Run = `LOW;
		end
		
		#`DELAY;	// Wait for result stable

		// Close output file for safety
		$fclose(output_file);

		// Stop the simulation
		$stop();
	end
	
	always @(posedge Ready)
	begin : Monitoring
		$display("Multiplicand:%d, Multiplier:%d", reg1_in, reg2_in);
		$display("result:%d", reg2_out);
		$fdisplay(output_file, "%t,%x", $time, reg2_out);
	end
	
endmodule
