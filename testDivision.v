`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:46:56 04/06/2015
// Design Name:   division
// Module Name:   S:/a/asw011/public/PrimeFactorization/testDivision.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: division
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testDivision;

	// Inputs
	reg [0:31] n;
	reg [0:15] d;
	reg clk;
	reg reset;

	// Outputs
	wire [0:31] q;
	wire isFactor;
	wire isDone;

	// Instantiate the Unit Under Test (UUT)
	division uut (
		.n(n), 
		.d(d), 
		.clk(clk),
		.reset(reset),
		.q(q), 
		.isFactor(isFactor), 
		.isDone(isDone)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs\
		reset = 0;
		clk = 0;
		n = 100;
		d = 11;
		#150;
		
		n = 100;
		d = 10;		
		reset = 1;
		#10;
		reset = 0;
		
		#150;
		n = 27;
		d = 3;
		reset = 1;
		#10;
		reset = 0;
		
		#150;
		n = 84;
		d = 40;
		reset = 1;
		#10;
		reset = 0;
		#150;
       
		 
		// Add stimulus here

	end
      
endmodule

