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
    input [63:0] boundary,
    output reg [63:0] e,
	 output reg done
    );

	reg input_enable;
	reg next_input_enable;
	reg next_done;
	reg [12:0] index;
	reg [12:0] next_index;
	reg [63:0] next_e;
	reg has_index_changed;
	reg next_has_index_changed;
	reg reset_exponentiation;
	reg next_reset_exponentiation;
	reg is_exponentiation_already_reset;
	reg next_is_exponentiation_already_reset;
	
	wire prime_list_ready;
	wire [8:0] data;
	wire exponent_finder_ready;
	wire [7:0] exponent;
	wire [99:0] exponentiation_result;
	wire exponentiation_ready;
	
	
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
		reset_exponentiation = 0;
		next_reset_exponentiation = 0;
		is_exponentiation_already_reset = 0;
		next_is_exponentiation_already_reset = 0;
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
	
	BinaryExponentiation binary_exponentiation (
    .clk(clk), 
    .base(data), 
    .exponent(exponent-8'd1), 
    .reset(reset_exponentiation), 
    .result(exponentiation_result), 
    .isDone(exponentiation_ready)
   );
	
	always @(posedge clk) begin
		input_enable <= next_input_enable;
		done <= next_done;
		index <= next_index;
		e <= next_e;
		has_index_changed <= next_has_index_changed;
		reset_exponentiation <= next_reset_exponentiation;
		is_exponentiation_already_reset <= next_is_exponentiation_already_reset;
	end
	
	always @(*) begin
		if (prime_list_ready) begin
			if (done) begin
				next_input_enable = 0;
				next_done = 1;
				next_index = index;
				next_e = e;
				next_has_index_changed = 0;
				next_reset_exponentiation = 0;
				next_is_exponentiation_already_reset = 0;
			end else begin
				if (exponent_finder_ready) begin // after the prime list is ready and the exponent is ready, caculate prime ^ exponent first
					if (!is_exponentiation_already_reset) begin 
						next_reset_exponentiation = 1; // pull the reset_exponentiation pin to high to start resetting 
						// don't change anything else
						next_input_enable = 0; // don't change the exponent finder
						next_done = 0;
						next_index = index;
						next_e = e;
						next_has_index_changed = 0;
						next_is_exponentiation_already_reset = 1;
					end else begin // if the exponentiation module is already reset, then wait until it's ready
						next_reset_exponentiation = 0; // pull down the reset_exponentiation pin
					
						if (exponentiation_ready == 1 && reset_exponentiation == 0) begin // if the exponentiation is ready, then go ahead and calcuates the final result. Note that reset pin should be low here
						
							if (exponent_finder_ready && (!has_index_changed) ) begin
								if (exponent-1 == 1) begin // if the exponent is 1, we don't have to use the exponentiation module. Instead, just multiply e with the base
									next_e = e * data;
								end else begin  // otherwise, use the result from the exponentiation module
									next_e = e * exponentiation_result ;
								end
								next_input_enable = 0;
								
								if (data >= 5) begin 
									next_done = 1;
								end else begin
									next_done = 0;
								end
								
								next_index = index + 1;
								next_has_index_changed = 1;
								next_is_exponentiation_already_reset = 1;
							end else begin
								next_input_enable = 1;
								next_done = 0;
								next_index = index;
								next_e = e;
								next_has_index_changed = 0;
								next_is_exponentiation_already_reset = 0;
							end
							
							
						end else begin
							next_input_enable = 0; // don't change the exppnent finder
							next_done = 0;
							next_index = index; // keep the prime
							next_e = e;
							next_has_index_changed = 0;
							next_is_exponentiation_already_reset = 1;
						end
					end
					
				end else begin
					next_is_exponentiation_already_reset = 0;
					next_reset_exponentiation = 0;
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
			next_is_exponentiation_already_reset = 0;
			next_reset_exponentiation = 1;
		end
	end
	
endmodule
