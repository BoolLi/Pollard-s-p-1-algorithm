`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:00 04/23/2015 
// Design Name: 
// Module Name:    modBigNumbers 
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
module modBigNumbers(input reset, input clk, input [63:0] exponent, input [31:0] number,
    output reg [31:0] result, output reg isDone
    );
	 
	 reg [31:0] nextResult;
	 reg [31:0] dividend;
	 reg nextIsDone;
	 reg [12:0] bitIndex;
	 reg [12:0] nextBitIndex;
	 reg [31:0] nextDividend;
	 
	 wire [31:0] remainder;
	 wire [31:0] quotient; 
	 wire [31:0] memMod;
	 wire rfd;

	initial begin
		nextIsDone = 0;
		isDone = 0;
		bitIndex = 0;
		nextBitIndex = 0;
		dividend = 1;
		nextDividend = 1;
		result = 0;
		nextResult = 0; 
	end
	
	 div_gen_v3_0 dviderModule (.clk(clk),.rfd(rfd),.dividend(dividend),.divisor(number), .quotient(quotient), .fractional(remainder)); 
	
	always @(posedge clk) begin
		result <= nextResult;
		isDone <= nextIsDone;
		bitIndex <= nextBitIndex;
		dividend <= nextDividend;
	end
	
	always @(*) begin
		if (rfd == 1) begin
			nextBitIndex = bitIndex < 64 ? bitIndex + 1 : bitIndex;
			if (bitIndex == 64) begin
				if (reset == 1) begin
					nextIsDone = 0;
					nextBitIndex = 0;
					nextDividend = 1;
					nextResult = 0;
				end
				else begin
					nextIsDone = 1;
					nextDividend = dividend;
					nextResult = remainder;
				end
			end
			
			else begin
				nextResult = result;
				nextIsDone = 0;
				if (exponent[bitIndex] == 1) begin
					nextDividend = remainder * memMod;
				end
				else begin
					nextDividend = dividend;
				end
			end
		end
		
		else begin
			nextBitIndex = bitIndex;
			nextDividend = dividend;
			nextResult = result;
			nextIsDone = isDone;
		end
	end
endmodule
