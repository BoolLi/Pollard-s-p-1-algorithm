`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:52 04/08/2015 
// Design Name: 
// Module Name:    factorFinder 
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
module factorFinder(
    input [0:31] product,
    input clk,
    output reg [0:15] factorA,
    output reg [0:15] factorB,
	 output reg isDone
    );
	 
	 reg [0:15] nextFactorA;
	 
	 reg reset;
	 reg nextReset;
	 
	 reg isFactor;
	 
	 
	 division divider (
		.n(product), 
		.d(factorA), 
		.clk(clk),
		.reset(reset),
		.q(factorB), 
		.isFactor(isFactor), 
		.isDone(isDone)
	);
	 
	 
	 initial begin
		nextFactorA = 2;
		nextReset = 0;
	 end
	 
	 always @(posedge clk) begin
		factorA <= nextFactorA;
		reset <= nextReset;
	 end
	 
	 always @(*) begin
		if (!isDone) begin
			nextFactorA = factorA;
			nextReset = 1;
		end else begin
			nextFactorA = factorA + 1;
			nextReset = 0;
		end
	 end


endmodule
