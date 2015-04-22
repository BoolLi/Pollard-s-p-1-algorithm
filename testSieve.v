`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:33:42 04/13/2015
// Design Name:   Sieve
// Module Name:   U:/public/PrimeFactorization/testSieve.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sieve
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testSieve;

	// Inputs
	reg clk;

	// Outputs
	wire [8:0] primeNumber;
	wire loop;

	// Instantiate the Unit Under Test (UUT)
	Sieve uut (
		.clk(clk), 
		.primeNumber(primeNumber), 
		.loop(loop)
	);
	
	always #1 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		// Add stimulus here

	end
      
endmodule

