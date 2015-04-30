`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:59 04/06/2015 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main(input clk, input [31:0] n, output [31:0] prime1 
    );
	 
	 wire isExponentFinderDone;
	 wire isLogCalculatorDone;
	 wire isGcdCalculatorDone;
	 wire isModCalculatorDone;
	 
	 reg enableLogCalculator;
	 reg next_enableLogCalculator;
	 wire [63:0] e;
	 wire [7:0] logCalcualtorResult;
	 wire[31:0] modResult;
	 
	 reg resetModCalculator;
	 reg next_resetModCalculator;
	 reg resetGcd;
	 reg next_resetGcd;
	 
	 
	 reg isModBigNumberEnabled;
	 reg nextIsModBigNumberEnabled;
	 reg isGcdEnabled;
	 reg nextIsGcdEnabled;
	 reg startMod;
	 reg nextStartMod;
	 
	 e_finder exponentFinder (.clk(clk), .boundary(n), .e(e), .done(isExponentFinderDone));
	 
	 exponent_finder logCalculator (.clk(clk), .boundary(n), .input_enable(enableLogCalculator), .base(9'd2), .exponent(logCalcualtorResult), .ready(isLogCalculatorDone));
	 
	 GCD gcdCalculator (.a(n), .b(modResult - 1), .reset(resetGcd), .clk(clk), .gcd(prime1), .isDone(isGcdCalculatorDone));
	 
	 modBigNumbers modCalculator (.reset(resetModCalculator), .clk(clk), .exponent(64'd192), .number(n),  .result(modResult), .isDone(isModCalculatorDone));
	 
	 initial begin
		enableLogCalculator = 0;
		next_enableLogCalculator = 1;
		resetModCalculator = 0;
		next_resetModCalculator = 0;
		resetGcd = 0;
		next_resetGcd = 0;
	   isModBigNumberEnabled = 0;
	   nextIsModBigNumberEnabled = 0;
		isGcdEnabled = 0;
		nextIsGcdEnabled = 0;
		startMod = 0;
		nextStartMod = 0;
	 end
	 
	 always @(posedge clk) begin
		enableLogCalculator <= next_enableLogCalculator;
		resetModCalculator <= next_resetModCalculator;
		resetGcd <= next_resetGcd;
		isModBigNumberEnabled <= nextIsModBigNumberEnabled;
		isGcdEnabled <= nextIsGcdEnabled;
		startMod <= nextStartMod;
	 end
	 
	 always @(*) begin
		next_enableLogCalculator = 1;
		next_resetModCalculator  = resetModCalculator;
		next_resetGcd = resetGcd ;
		nextIsModBigNumberEnabled = isModBigNumberEnabled ;
		nextIsGcdEnabled = isGcdEnabled;
		nextStartMod = startMod;
		if (isLogCalculatorDone & isExponentFinderDone) begin // check if log(2,n) is done
			if (isModBigNumberEnabled == 1)
				next_resetModCalculator = 0;
			else begin
				next_resetModCalculator = 1;
				nextIsModBigNumberEnabled = 1;
				nextStartMod = 1;
			end
		end 
		
		
		if (isModCalculatorDone) begin
			if (isGcdEnabled == 1)
				next_resetGcd = 0;
			else begin
				next_resetGcd = 1;
				nextIsGcdEnabled = 1;
			end
		end 
		
	 end
	 

endmodule
