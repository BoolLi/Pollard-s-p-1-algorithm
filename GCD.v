`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:33 04/09/2015 
// Design Name: 
// Module Name:    GCD 
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
module GCD(input [63:0] a, input [63:0] b, input reset, input clk, output reg [31:0] gcd, output reg isDone
    );
	 
	reg [63:0] nextInputA;
	reg [63:0] nextInputB;
	reg [63:0] inputA;
	reg [31:0] inputB;
	reg [63:0] nextExponent;
	reg [63:0] exponent;
	reg [63:0] nextGcd;
	reg nextIsDone;

	initial begin
		nextInputA = 0;
		nextInputB = 0;
		inputA = 0;
		inputB = 0;
		nextExponent = 0;
		exponent = 0;
		nextIsDone = 0;
		isDone = 0;
		nextGcd = 0;
		gcd = 0;
	end
	
	always @(posedge clk) begin
		inputA <= nextInputA;
		inputB <= nextInputB;
		exponent <= nextExponent;
		isDone <= nextIsDone;
		gcd <= nextGcd;
	end
	
	always @(*) begin
		nextInputA = inputA;
		nextInputB = inputB;
		nextIsDone = isDone;
		nextExponent = exponent;
		nextGcd = gcd;
		
		if (reset == 1) begin
			nextInputA = 0;
			nextInputB = 0;
			nextExponent = 0;
			nextIsDone = 0;
		end
		
		else begin
			if (inputA == 0) begin
				nextInputA = a;
				nextInputB = b;
			end
			
			else begin
			
				if ((inputA == inputB) & isDone == 0 & inputA > 0) begin
					nextGcd = inputA << exponent;
					nextIsDone = 1;
				end
				
				else begin
					if ((inputA[0] == 0) & (inputB [0] == 0)) begin
						nextExponent = exponent + 1;
						nextInputA = inputA >> 1;
						nextInputB = inputB >> 1;
					end
					
					else begin
						nextExponent = exponent;
						
						if (inputA[0] == 0) begin
							nextInputA = inputA >> 1;
						end
						
						else begin
							if (inputB[0] ==  0) begin
								nextInputB = inputB >> 1;
							end
							
							else begin
								if (inputA > inputB) begin
									nextInputA = (inputA - inputB) >> 1;
								end
								
								else begin
									nextInputB = (inputB - inputA) >> 1;
								end
								
							end
							
						end
						
					end
		
				end
				
			end
			
		end
		
	end


endmodule
