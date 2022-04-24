module ram
 #(	parameter	ram_width = 12,
	parameter	bus_width = 3
 )
 (	input clk,
	input rw,
	input [63:0]	addr,
	output [63:0]		read,
	input [63:0] 		write,
	output exception
 );
	integer i;
	reg [63:0] ram_array [0:2**(ram_width - bus_width)];
	initial begin
		`include "flash_array.vh"
		for(i=`INITIAL_SP;i<`IO_INIT;i=i+1) begin
			ram_array[i]=0;
		end
	end
	
	assign read = exception | rw? 0: ram_array[addr >> bus_width]; //Each cell have 4 bytes
	assign exception = |addr[63:ram_width + 1] | |addr[1:0]? 1: 0; //Checking, first out of range, second alignent
	
	always @(posedge clk) begin
		if (rw & ~exception)
			ram_array[addr] <= write;
	end

endmodule
