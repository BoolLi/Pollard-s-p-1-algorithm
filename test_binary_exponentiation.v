`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:20:44 04/16/2015
// Design Name:   BinaryExponentiation
// Module Name:   H:/Users/asw011/Downloads/PrimeFactorization (1)/PrimeFactorization/test_binary_exponentiation.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BinaryExponentiation
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_binary_exponentiation;

	// Inputs
	reg [8:0] base;
	reg [7:0] exponent;
	reg clk, reset;

	// Outputs
	wire [99:0] result;
	wire isDone;

	// Instantiate the Unit Under Test (UUT)
	BinaryExponentiation uut (
		.clk(clk),
		.base(base), 
		.exponent(exponent), 
		.reset(reset),
		.result(result), 
		.isDone(isDone)
	);
	
	always #2 clk = ~clk;

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		base = 0;
		exponent = 0;
		#10;
		
		base = 2;
		exponent = 25;
		#150;
		base = 3;
		exponent = 17;
		reset = 1;
		#5;
		reset = 0;
		#150;
		base = 5;
		exponent = 30;
		reset = 1;
		#5;
		reset = 0;
		#150;
		base = 11;
		exponent = 1;
		reset = 1;
		#5;
		reset = 0;
		
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

