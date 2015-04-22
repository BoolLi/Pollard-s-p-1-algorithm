`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:30:24 04/06/2015 
// Design Name: 
// Module Name:    division 
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
module division(input [0:31] n, input [0:15] d, input clk, input reset, output reg [0:31] q, output reg isFactor, output reg isDone
    );

	reg [0:31] nextQ;
	reg [0:31] remainder;
	reg [0:31] nextRemainder;
	reg nextIsFactor;
	reg nextIsDone;

	initial begin
		nextRemainder = -1;
		nextQ = 32'b0;
		remainder = -1;
		q = 32'b0;
		nextIsFactor = 1'b0;
		nextIsDone = 1'b0;
	end
	
	always @(posedge clk) begin
		remainder <= nextRemainder;
		isFactor <= nextIsFactor;
		isDone <= nextIsDone;
		q <= nextQ;
	end
	
	always @(*) begin
		if (reset == 1) begin
			nextRemainder = -1;
			nextQ = 32'b0;
			nextIsFactor = 1'b0;
			nextIsDone = 1'b0;
		end
		else begin
			case (remainder) 
				-1: begin
						nextRemainder = n;
						nextQ = 32'b0;
						nextIsFactor = 1'b0;
						nextIsDone = 1'b0;
					end
				default: begin
						nextRemainder = remainder >= d ? remainder - d : remainder;
						nextQ = remainder >= d ? q + 1 : q;
						nextIsFactor = remainder  == 0 ? 1 : 0;
						nextIsDone = remainder < d ? 1 : 0;
					end
			endcase
		end
	end
	


endmodule
