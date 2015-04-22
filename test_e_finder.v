`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:41:39 04/21/2015
// Design Name:   e_finder
// Module Name:   H:/Users/ll024/Downloads/PrimeFactorization (1)/PrimeFactorization/PrimeFactorization/test_e_finder.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: e_finder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_e_finder;

	// Inputs
	reg clk;
	reg [7:0] boundary;

	// Outputs
	wire [64:0] e;
	wire done;

	// Instantiate the Unit Under Test (UUT)
	e_finder uut (
		.clk(clk), 
		.boundary(boundary), 
		.e(e), 
		.done(done)
	);

	always #1 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 1;
		boundary = 100;

		// Wait 100 ns for global reset to finish
		#3000;
        
		// Add stimulus here

	end
      
endmodule

