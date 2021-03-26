module ram
 #(	parameter	ram_width = 12
 )
 (	input rw,
	input [1:0] len,
	input [31:0]	addr,
	output wire [31:0]		read,
	input [31:0] 		write,
	output wire exception
 );
	integer i;
	reg [7:0] ram_array [0:2**ram_width];
	initial begin
		`include "flash_array.vh"
		for(i=`INITIAL_SP;i<`IO_INIT;i=i+1) begin
			ram_array[i]=0;
		end
	end
	
	assign read = exception | rw? 0: ram_array[addr];
	assign exception = |addr[31:ram_width + 1]? 1: 0;
	
	always @(addr, rw) begin
		if (rw & ~exception) begin
			ram_array[addr] <= 255;//write;
		end
	end

endmodule
