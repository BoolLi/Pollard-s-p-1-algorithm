`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:05 04/13/2015 
// Design Name: 
// Module Name:    Sieve 
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
module Sieve(input clk, output reg [8:0] primeNumber, output reg loop
    );
	 
	reg [255:0] nextNumberArray;
	reg [255:0] numberArray;
	reg [9:0] nextIndex;
	reg [9:0] index;
	reg nextLoop;
	
	reg [8:0] nextPrimeNumber;
	
	initial begin
		nextNumberArray = 256'b0;
		nextNumberArray = ~nextNumberArray;
		numberArray = 256'b0;
		numberArray = ~numberArray;
		index = 10'd4;
		nextIndex = 10'd4;
		nextPrimeNumber = 9'd2;
		primeNumber = 9'd2;
		loop = 0;
		nextLoop = 0;
	end
	
	always @ (posedge clk) begin
		numberArray <= nextNumberArray;
		index <= nextIndex;
		primeNumber <= nextPrimeNumber;
		loop <= nextLoop;
	end
	
	always @ (*) begin
		if (index < 256) begin
			nextNumberArray[index] = 0;
			nextIndex = index + primeNumber;
			nextPrimeNumber = primeNumber;
			nextLoop = 0;
		end
		
		else begin
			nextNumberArray = numberArray;
			if (loop) begin
				if (numberArray[primeNumber] == 0) begin
					nextPrimeNumber = primeNumber + 1;
					nextLoop = 1;
					nextIndex = index;
				end
				
				else begin
					nextPrimeNumber = primeNumber;
					nextIndex = primeNumber + primeNumber;
					nextLoop = 0;
				end
			end
			
			else begin
				nextPrimeNumber = primeNumber + 1;
				nextLoop = 1;
				nextIndex = index;
			end
		end
	end

endmodule
