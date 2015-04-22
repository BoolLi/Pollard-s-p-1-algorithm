`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:15 04/19/2015 
// Design Name: 
// Module Name:    exponent_finder 
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
module exponent_finder(
	 input clk,
    input [7:0] boundary,
    input input_enable,
    input [8:0] base,
    output reg [7:0] exponent,
	 output reg ready
    );
	 
	 reg [7:0] next_exponent;
	 reg next_ready;
	 reg [7:0] temp_product;
	 reg [7:0] next_temp_product;
	 
	 
	 initial begin
		next_ready = 0;
		next_exponent = 0;
		next_temp_product = 1;
	 end
	 
	 always @(posedge clk) begin
		ready <= next_ready;
		exponent <= next_exponent;
		temp_product <= next_temp_product;
	 end
	 
	 always @(*) begin
		if (input_enable) begin
			if (temp_product < boundary) begin
				next_temp_product = temp_product * base;
				next_ready = 0;
				next_exponent = exponent + 1;
			end else begin
				next_temp_product = temp_product;
				next_ready = 1;
				next_exponent = exponent;
			end
		end else begin
			next_temp_product = 1;
			next_ready = 0;
			next_exponent = 0;
		end
	 end


endmodule
