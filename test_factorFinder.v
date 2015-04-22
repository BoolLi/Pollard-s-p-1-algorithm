`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:52:23 04/08/2015
// Design Name:   factorFinder
// Module Name:   S:/a/asw011/public/PrimeFactorization/test_factorFinder.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: factorFinder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_factorFinder;

	// Inputs
	reg [0:31] product;
	reg clk;

	// Outputs
	wire [0:15] factorA;
	wire [0:15] factorB;
	wire isDone;

	// Instantiate the Unit Under Test (UUT)
	factorFinder uut (
		.product(product), 
		.clk(clk), 
		.factorA(factorA), 
		.factorB(factorB), 
		.isDone(isDone)
	);
	
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		product = 0;
		clk = 0;
		
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
      
endmodule

