`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:18:11 04/20/2015
// Design Name:   exponent_finder
// Module Name:   H:/Users/ll024/Downloads/PrimeFactorization/PrimeFactorization/test_exponent_finder.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: exponent_finder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_exponent_finder;

	// Inputs
	reg clk;
	reg [7:0] boundary;
	reg input_enable;
	reg [8:0] base;

	// Outputs
	wire [7:0] exponent;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	exponent_finder uut (
		.clk(clk), 
		.boundary(boundary), 
		.input_enable(input_enable), 
		.base(base), 
		.exponent(exponent), 
		.ready(ready)
	);

	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 1;
		boundary = 100;
		input_enable = 1;
		base = 2;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

