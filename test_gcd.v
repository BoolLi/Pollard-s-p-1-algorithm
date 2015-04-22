`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:45:26 04/09/2015
// Design Name:   GCD
// Module Name:   S:/a/asw011/public/PrimeFactorization/test_gcd.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GCD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_gcd;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] gcd;
	wire isDone;

	// Instantiate the Unit Under Test (UUT)
	GCD uut (
		.a(a), 
		.b(b), 
		.reset(reset), 
		.clk(clk),
		.gcd(gcd), 
		.isDone(isDone)
	);

	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		a = 42;
		b = 63;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#250;
		reset = 1;
		a = 45;
		b = 10;
		#15
		reset = 0;
		#250
	
		reset = 1;
		a = 40;
		b = 20;
		#15
		reset = 0;
		
		
        
		// Add stimulus here

	end
      
endmodule

