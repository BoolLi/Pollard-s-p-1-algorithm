`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:21:51 04/26/2015
// Design Name:   main
// Module Name:   H:/Users/asw011/Documents/Final Project Elec 245/Final Project Elec 245/Final Project Elec 245 (1)/Final Project Elec 245/PrimeFactorization/test_main.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_main;

	// Inputs
	reg clk;
	reg [31:0] n;

	// Outputs
	wire [31:0] prime1;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.n(n), 
		.prime1(prime1)
	);
	
	
	always #1 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 1;
		n = 485;

		// Wait 100 ns for global reset to finish
		#5000;
        
		// Add stimulus here

	end
      
endmodule

