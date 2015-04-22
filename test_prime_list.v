`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:04:34 04/14/2015
// Design Name:   PrimeList
// Module Name:   H:/Users/ll024/Desktop/PrimeFactorization/test_prime_list.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PrimeList
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_prime_list;

	// Inputs
	reg clk;
	reg [12:0] index;

	// Outputs
	wire ready;
	wire [8:0] data;

	// Instantiate the Unit Under Test (UUT)
	PrimeList uut (
		.clk(clk), 
		.index(index), 
		.ready(ready), 
		.data(data)
	);
	always #1 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		index = 13'b0000000000001;

		// Wait 100 ns for global reset to finish
		#2600;

		index = 13'b0000000000010;
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		
		#100;
		index = index + 1;
		// Add stimulus here

	end
      
endmodule

