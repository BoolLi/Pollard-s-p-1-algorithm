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
module modBigNumbers(
	 input reset,
	 input start,
	 input clk,
    input [63:0] exponent,
    input [63:0] number,
    input [7:0] logNum,
    output reg [63:0] outputResult,
	 output reg isDone
    );
	 
	 reg [1000:0] nextResult;
	 reg [1000:0] result;
	 reg [63:0] nextOutputResult;
	 reg nextIsDone;

	initial begin
		nextResult = 0;
		nextIsDone = 0;
		outputResult = 0;
		nextOutputResult = 0;
		result = 0; 
		isDone = 0;
	end
	
	always @(posedge clk) begin
		result <= nextResult;
		isDone <= nextIsDone;
		outputResult <= nextOutputResult;
	end
	
	always @(*) begin
		nextResult = result;
		nextIsDone = isDone;
		nextOutputResult = outputResult;
		if (start) begin
			if (isDone == 1) begin
				nextOutputResult = result[63:0];
				if (reset == 1) begin
					nextIsDone = 0;
					nextResult = 0;
				end	
					
				else begin
					nextIsDone = isDone;
					nextResult = result;
				end
			end
			
			else begin
				nextIsDone = isDone;
				if (result == 0 & exponent > 0)
					nextResult  = (1 << exponent) - number * (1 << (exponent - logNum - 1));
				else if (result > number)
					nextResult = result - number;
				else begin
					nextResult = result;
					nextIsDone = 1;
				end
			end
		end
	end
	
endmodule
