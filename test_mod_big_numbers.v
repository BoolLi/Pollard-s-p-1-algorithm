`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:19:07 04/23/2015
// Design Name:   modBigNumbers
// Module Name:   U:/public/Final Project Elec 245/PrimeFactorization/test_mod_big_numbers.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: modBigNumbers
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mod_big_numbers;

	// Inputs
	reg [63:0] exponent;
	reg [63:0] number;
	reg [7:0] logNum;
	reg clk, reset;
	reg start;

	// Outputs
	wire [63:0] result;
	wire isDone;

	// Instantiate the Unit Under Test (UUT)
	modBigNumbers uut (
		.reset(reset),
		.start(start),
		.clk(clk),
		.exponent(exponent), 
		.number(number), 
		.logNum(logNum), 
		.result(result), 
		.isDone(isDone)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		start = 0;
		reset = 0;
		clk = 0;
		exponent = 0;
		number = 0;
		logNum = 0;

		// Wait 100 ns for global reset to finish
		#100;
		start = 1;
		reset = 1;
		exponent = 64'd96;
		number = 485;
		logNum = 9;
		#15;
		reset = 0;
		#10000000;
		reset = 1;
		exponent = 12;
		number = 87;
		logNum = 6;
		#15;
		reset = 0;
		#600;
		reset = 1;
		exponent = 13;
		number = 311;
		logNum = 8;
		#15;
		reset = 0;
        
		# 100;
		// Add stimulus here

	end
      
endmodule

