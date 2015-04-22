`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:08:24 04/14/2015 
// Design Name: 
// Module Name:    PrimeList 
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
module PrimeList(input clk, input [12:0] index, output reg ready, output wire [8:0] data
    );
	 
	 reg wea;
	 reg next_wea;
	 reg [12:0] memory_index;
	 reg [12:0] next_memory_index;
	 
	 reg next_ready;
	 reg is_memory_being_written;
	 reg next_is_memory_being_written;
	 
	wire loop;
	wire [8:0] prime_number;
	 
	 memory list (
	   .clka(clk), // input clka
	   .wea(wea), // input [0 : 0] wea
	   .addra(memory_index), // input [12 : 0] addra
	   .dina(prime_number), // input [8 : 0] dina
	   .douta(data) // output [8 : 0] douta
	 );
	
	 Sieve sieve (
		 .clk(clk), 
		 .primeNumber(prime_number), 
		 .loop(loop)
    );
	 
	 initial begin
		memory_index = 0;
		next_memory_index = 0;
		wea = 0;
		next_wea = 0;
		ready = 0;
		next_ready  = 0;
		is_memory_being_written = 0;
		next_is_memory_being_written = 0;
	 end
	 
	 always @(posedge clk)
	 begin
		memory_index <= next_memory_index;
		wea <= next_wea;
		ready <= next_ready;
		is_memory_being_written <= next_is_memory_being_written;
	 end
	 
	 always @(*)
	 begin
		if (prime_number <= 0) begin // if the current prime number is negative, meaning that the sieve is done
			next_memory_index = index;
			next_wea = 0;
			next_ready = 1;
			next_is_memory_being_written = 0;
		end else begin // if the current prime number is positive, meaning the sieve is still running
			if (!loop) begin // if the next prime is generated, write it to memory
				if (!is_memory_being_written) begin
					next_memory_index = memory_index + 1;
					next_wea = 1;
					next_is_memory_being_written = 1;
				end else begin
					next_memory_index = memory_index;
					next_wea = 0;
					next_is_memory_being_written = 1;
				end
			end else begin // if the next prime is not generated yet, just wait
				next_memory_index = memory_index;
				next_wea = 0;
				next_is_memory_being_written = 0;
			end
			next_ready  = 0;
		end
	 end

endmodule
