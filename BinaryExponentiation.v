`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:08 04/16/207 
// Design Name: 
// Module Name:    BinaryExponentiation 
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
module BinaryExponentiation( input clk, input [8:0] base, input [7:0] exponent, input reset,
		output reg [99:0] result, output reg isDone
    );
	
	reg [99:0] nextResult;
	reg nextIsDone;
	reg [3:0] nextIndex;
	reg [3:0] index;
	reg nextStart;
	reg start;
	
	initial begin
		nextResult = 0;
		result = 0;
		nextIsDone = 0;
		isDone = 0;
		index = 7;
		nextIndex = 7;
		nextStart = 0;
		start = 0;
	end
	
	always @ (posedge clk) begin
			result <= nextResult;
			isDone <= nextIsDone;
			index <= nextIndex;
			start <= nextStart;
	end

	always @ (*) begin
		if (result == 0) begin
			nextResult = base;
			nextIsDone = 0;
		end
		
		else begin
			if (isDone == 1) begin
				if (reset == 1) begin
					nextIsDone = 0;
					nextResult = 0;
					nextIndex = 7;
					nextStart = 0;
				end
				
				else begin
					nextIsDone = 1;
					nextResult = result;
					nextIndex = index;
					nextStart = start;
				end
			end
			
			else begin
				nextIndex = index > 0 ? index - 1 : index;
				nextIsDone = 0;
				nextStart = start;
				
				if (exponent[index] == 1 & start == 0) begin
					nextStart = 1;
					nextResult = result;
				end
				
				if (start == 1) begin
					if (exponent[index] == 0) begin
						nextResult = result * result;
					end
					
					else begin
						nextResult = result * result * base;
					end
					
					if (index == 0) begin
						nextIsDone = 1;
					end
				end
			end
		end
	end

endmodule
