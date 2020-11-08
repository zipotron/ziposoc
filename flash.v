module flash
 #(	parameter	flash_width = 9
 )
 (	input wire	[flash_width+2:0]	addr,
	output wire	[31:0]			data,
	output wire exception
 );

	reg [31:0] flash_array [0:2**flash_width];

	initial begin
		`include "flash_array.v"
	end

	assign data = flash_array[addr>>2];
	assign exception = |addr[1:0];
	
endmodule
