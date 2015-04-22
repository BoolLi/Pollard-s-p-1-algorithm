`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:32:42 04/14/2015
// Design Name:   memory
// Module Name:   H:/Users/ll024/Desktop/PrimeFactorization/test_memory.v
// Project Name:  PrimeFactorization
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_memory;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [12:0] addra;
	reg [8:0] dina;

	// Outputs
	wire [8:0] douta;

	// Instantiate the Unit Under Test (UUT)
	memory uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);
	always #5 clka = ~clka;
	initial begin
		// Test writing data
		clka = 1;
		wea = 1;
		addra = 13'b0010001000101;
		dina = 23;

		// Test reading data
		#100;
		
		clka = 1;
		wea = 0;
		addra = 13'b0010001000101;
		dina = 78;  // this won't overwrite data because wea is 0

	end
      
endmodule

