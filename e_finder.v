`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:22 04/21/2015 
// Design Name: 
// Module Name:    e_finder 
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
module e_finder(
    input clk,
    input [7:0] boundary,
    output reg [64:0] e,
	 output reg done
    );

	reg input_enable;
	reg next_input_enable;
	reg next_done;
	reg [12:0] index;
	reg [12:0] next_index;
	reg [64:0] next_e;
	reg has_index_changed;
	reg next_has_index_changed;
	
	wire prime_list_ready;
	wire [8:0] data;
	wire exponent_finder_ready;
	wire [7:0] exponent;
	
	initial begin
		input_enable = 0;
		next_input_enable = 0;
		done = 0;
		next_done = 0;
		index = 1;
		next_index = 1; // index starts with 1
		e = 1;
		next_e = 1;
		has_index_changed = 0;
		next_has_index_changed = 0;
	end
	
	PrimeList prime_list (
    .clk(clk), 
    .index(index), 
    .ready(prime_list_ready), 
    .data(data)
   );

	exponent_finder log (
		 .clk(clk), 
		 .boundary(boundary), 
		 .input_enable(input_enable), 
		 .base(data), 
		 .exponent(exponent), 
		 .ready(exponent_finder_ready)
	);
	
	always @(posedge clk) begin
		input_enable <= next_input_enable;
		done <= next_done;
		index <= next_index;
		e <= next_e;
		has_index_changed <= next_has_index_changed;
	end
	
	always @(*) begin
		if (prime_list_ready) begin
			if (done) begin
				next_input_enable = 0;
				next_done = 1;
				next_index = index;
				next_e = e;
				next_has_index_changed = 0;
			end else begin
				if (exponent_finder_ready && (!has_index_changed) ) begin
					next_e = e * (data ** (exponent-1) );
					next_input_enable = 0;
					
					if (data >= 11) begin 
						next_done = 1;
					end else begin
						next_done = 0;
					end
					
					next_index = index + 1;
					next_has_index_changed = 1;
				end else begin
					next_input_enable = 1;
					next_done = 0;
					next_index = index;
					next_e = e;
					next_has_index_changed = 0;
				end
			end
			
		end else begin
			next_input_enable = 0;
			next_done = 0;
			next_index = 1;
			next_e = e;
			next_has_index_changed = 0;
		end
	end
	
endmodule
